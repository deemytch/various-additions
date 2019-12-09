require 'monkey-hash'

# Ждём сообщения в очередь, при наступлении таймаута (если указан) вкидываем nil.

class QueueWithTimeout < Queue
  def pop( tmout = nil )
    if tmout.present? && tmout > 0
      that      = self
      dog       = Thread.new {
        sleep tmout
        that << nil
      }
    end
    ret = super()
    dog.kill.join
    return ret
  end
end
