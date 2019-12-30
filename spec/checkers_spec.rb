require_relative '../lib/checkers'
require 'date'
require 'pathname'
require 'yaml'
require 'sequel'

RSpec.describe Checkers do

  $cfg = YAML.load_file( "#{ Pathname(__FILE__).dirname.parent.expand_path }/config/database.yml" )
  Sequel.connect( $cfg.merge('database' => 'postgres', 'user' => 'postgres', 'password' => nil ) ) do |db|
    db.execute "DROP DATABASE IF EXISTS #{ $cfg['database'] }"
    db.execute "CREATE DATABASE #{ $cfg['database'] }"
  end

  $db = Sequel.connect $cfg
  $db.create_table :test_reports do
    column :id, Integer
    column :created_at, Time
  end

  class TestReport < Sequel::Model
  end

  let(:cfg_tmout) { 100 }
  let(:report_old) { report_old = TestReport.create( id: 1, created_at: Time.now - cfg_tmout - 10 ) }
  let(:report_new) { report_new = TestReport.create( id: 2, created_at: Time.now - cfg_tmout + 10 ) } 
  
  after :all do
    $db.drop_table :test_reports
  end

  it 'протух ли отчёт?' do
    expect( Checkers.tmout_any?( cfg_tmout, report_old ) ).to be_truthy
    expect( Checkers.tmout_all?( cfg_tmout, report_old ) ).to be_truthy

    expect( Checkers.tmout_any?( cfg_tmout, report_new ) ).to be_falsy
    expect( Checkers.tmout_all?( cfg_tmout, report_new ) ).to be_falsy

    expect( Checkers.tmout_any?( cfg_tmout, report_new, report_old ) ).to be_truthy
    expect( Checkers.tmout_any?( cfg_tmout, report_old, report_old ) ).to be_truthy
    expect( Checkers.tmout_any?( cfg_tmout, report_new, report_new ) ).to be_falsy

    expect( Checkers.tmout_all?( cfg_tmout, report_new, report_old ) ).to be_falsy
    expect( Checkers.tmout_all?( cfg_tmout, report_old, report_old ) ).to be_truthy
    expect( Checkers.tmout_all?( cfg_tmout, report_new, report_new ) ).to be_falsy
  end

  it 'протухла ли дата?' do
    expect( Checkers.tmout_any?( cfg_tmout, DateTime.now - cfg_tmout - 1 ) ).to be_truthy
    expect( Checkers.tmout_any?( cfg_tmout, DateTime.now - cfg_tmout + 1 ) ).to be_falsy

    expect( Checkers.tmout_all?( cfg_tmout, DateTime.now - cfg_tmout - 1 ) ).to be_truthy
    expect( Checkers.tmout_all?( cfg_tmout, DateTime.now - cfg_tmout + 1 ) ).to be_falsy
  end

  it 'протухло ли время?' do
    expect( Checkers.tmout_any?( cfg_tmout, Time.now - cfg_tmout - 1 ) ).to be_truthy
    expect( Checkers.tmout_any?( cfg_tmout, Time.now - cfg_tmout + 1 ) ).to be_falsy

    expect( Checkers.tmout_all?( cfg_tmout, Time.now - cfg_tmout - 1 ) ).to be_truthy
    expect( Checkers.tmout_all?( cfg_tmout, Time.now - cfg_tmout + 1 ) ).to be_falsy
  end

  it 'протухло ли время в секундах?' do
    expect( Checkers.tmout_any?( cfg_tmout, Time.now.to_i - cfg_tmout - 1 ) ).to be_truthy
    expect( Checkers.tmout_any?( cfg_tmout, Time.now.to_i - cfg_tmout + 1 ) ).to be_falsy

    expect( Checkers.tmout_all?( cfg_tmout, Time.now.to_i - cfg_tmout - 1 ) ).to be_truthy
    expect( Checkers.tmout_all?( cfg_tmout, Time.now.to_i - cfg_tmout + 1 ) ).to be_falsy
  end
end
