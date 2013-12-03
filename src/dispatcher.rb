class Dispatcher
  def initialize
    @subscribers = Hash.new{ |hash, key| hash[key] = [] }
  end

  def subscribe subscriber, symbol, callback, priority = 0
    @subscribers[symbol].push({ subscriber: subscriber, callback: callback, priority: priority })
    @subscribers[symbol].sort! { |a,b| b[:priority] <=> a[:priority] }
  end

  def dispatch symbol
    @subscribers[symbol].each do |sub| 
      subscriber = sub[:subscriber] 
      callback = sub[:callback]
      consumed = subscriber.send(callback)
      break if consumed 
    end 
  end

end
