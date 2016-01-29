require "sendgrid-ruby"

module OttInfra
  class SendMail
    attr_accessor :config

    def initialize( opts = {} )
      @config = {
        :sendgrid_from => opts[:from],
        :sendgrid_user => opts[:user],
        :sendgrid_pass => opts[:pass]
      }
    end

    def sendmail(email, opts = {})
      mail = SendGrid::Mail.new do |m|
        m.from = @config[:sendgrid_from]
        m.to = email
        m.cc = opts[:cc]
        m.subject = opts[:subject]
        m.html = opts[:message]
      end
      SendGrid::Client.new(sendmail_options).send mail
    end

    private

    def sendmail_options
      { api_user: @config[:sendgrid_user], api_key: @config[:sendgrid_pass] }
    end
  end
end
