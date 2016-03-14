require 'sendgrid-ruby'

module OttInfra
  ##
  # This class represents of SendGrid module
  class SendMail
    attr_accessor :config, :mails

    def initialize(opts = {})
      create_client opts
      @mails = []
    end

    def add(opts = {})
      @mails.push create_mail(opts)
    end

    def sendmail
      @mails.each do |mail|
        client_send mail
      end
    end

    def self.sendmail(opts = {})
      sendmail = new(opts)
      sendmail.add opts
      sendmail.sendmail
    end

    private

    def create_client(opts)
      @config = opts
      @client = SendGrid::Client.new(sendmail_options)
    end

    def create_mail(opts = {})
      SendGrid::Mail.new do |m|
        m.from = opts[:from]
        m.to = opts[:to]
        m.cc = opts[:cc]
        m.subject = opts[:subject]
        m.html = opts[:message]
      end
    end

    def client_send(mail)
      @client.send mail
    end

    def sendmail_options
      { api_user: @config[:user], api_key: @config[:pass] }
    end
  end
end
