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

    def initialize
      @config = {
        :sendgrid_from => ENV['SENDGRID_FROM'],
        :sendgrid_user => ENV['SENDGRID_USER'],
        :sendgrid_pass => ENV['SENDGRID_PASS']
      }
    end

    def sendmail(email, opts = {})
      opts[:subject] ||= "Subject"
      opts[:message] ||= "Message"
      mail = SendGrid::Mail.new do |m|
        m.to = email
        m.from = @config[:sendgrid_from]
        m.subject = opts[:subject]
        m.html = opts[:message]
      end
      if ( opts[:attach].is_a? Array )
        opts[:attach].each do |path|
          mail.add_attachment(path)
        end
      end
      SendGrid::Client.new(sendmail_options).send mail
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
