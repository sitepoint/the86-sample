class User

  class << self

    attr_writer :session

    def find(id)
      where(id: id).first || raise("User #{id} not found")
    end

    def where(attributes)
      session_users.select do |user|
        attributes.keys.all? do |key|
          user.send(key) == attributes[key]
        end
      end
    end

    def create(attributes)
      self.new(attributes.merge(id: next_id)).tap do |u|
        session_users << u
      end
    end

    private

    def next_id
      (session_users.map(&:id).max || 0) + 1
    end

    def session
      @session || raise("User has no reference to session")
    end

    def session_users
      session[:users] ||= []
    end

  end

  def initialize(attributes)
    attributes.each { |key, value| send("#{key}=", value) }
  end

  attr_accessor :id, :name

end
