module Reggora
    class Conversation
      def initialize(client)
        @model = 'conversation'
        @client = client
      end
      # returns a Conversation object
      def find_by_id(id)
        @client.get("/#{@model}/#{id}")
      end
  
      # Sends a message in the specified conversation
      def send_message(id, message_params)
        @client.post("/#{@model}/#{id}", message_params)
      end
    end
  end