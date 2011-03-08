module Heroku
  module Bartender
    class Commit
      attr_accessor :sha, :author, :email, :message, :date
      def initialize(stub = {})
        @sha     = stub[:sha]
        @author  = stub[:author]
        @email   = stub[:email]
        @message = stub[:message]
        @date    = stub[:date]
      end
    end
  end
end
