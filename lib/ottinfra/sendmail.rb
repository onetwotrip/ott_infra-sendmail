require "sendgrid-ruby"

class Hash
  def has_shape?(shape)
    all? do |k, v|
      Hash === v ? v.has_shape?(shape[k]) : shape[k] === v
    end
  end
end

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
      if valid?
        mail = SendGrid::Mail.new do |m|
          m.from = @config[:sendgrid_from]
          m.to = email
          m.cc = opts[:cc]
          m.subject = opts[:subject]
          m.html = opts[:message]
        end
        SendGrid::Client.new(sendmail_options).send mail
      end
    end

    def valid?
      @config.has_shape?({
        :sendgrid_from => String,
        :sendgrid_user => String,
        :sendgrid_pass => String
      })
    end

    private

    def sendmail_options
      { api_user: @config[:sendgrid_user], api_key: @config[:sendgrid_pass] }
    end
  end
end
