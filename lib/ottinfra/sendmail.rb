require "sendgrid-ruby"

module OttInfra
  class SendMail
    attr_accessor :config, :mails

    def initialize( opts = {} )
      prep_config( opts )
      self.mails = []
    end

    def prep_config( opts = {} )
      @config = {
        :sendgrid_from => opts[:from],
        :sendgrid_user => opts[:user],
        :sendgrid_pass => opts[:pass]
      }
      @client = SendGrid::Client.new(sendmail_options)
    end

    def add( mail )
      @mails.push mail
    end

    def sendmail
      @mails.each do |mail|
        client_send( mail )
      end
    end

    def self.sendmail( opts = {} )
      prep_config( opts )
      mail = SendGrid::Mail.new do |m|
        m.from = @config[:sendgrid_from]
        m.to = opts[:to]
        m.cc = opts[:cc]
        m.subject = opts[:subject]
        m.html = opts[:message]
      end
      client_send( mail )
    end

    private

    def client_send( mail )
      @client.send mail
    end

    def sendmail_options
      { api_user: @config[:sendgrid_user], api_key: @config[:sendgrid_pass] }
    end
  end
end
