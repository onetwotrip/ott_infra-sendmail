require "spec_helper"

describe OttInfra::SendMail do
  before(:each) do
    ENV["SENDGRID_USER"] = 'sendgrid_user'
    ENV["SENDGRID_PASS"] = 'sendgrid_pass'
    ENV["SENDGRID_FROM"] = 'sendgrid_from'
  end
  it "check config instance variable" do
    sendmail = OttInfra::SendMail.new
    expect( sendmail.config[:sendgrid_user] ).to match( "sendgrid_user" )
    expect( sendmail.config[:sendgrid_pass] ).to match( "sendgrid_pass" )
    expect( sendmail.config[:sendgrid_from] ).to match( "sendgrid_from" )
  end
  it ".valid? checks" do
    ENV.delete("SENDGRID_USER")
    ENV.delete("SENDGRID_PASS")
    ENV.delete("SENDGRID_FROM")
    expect( OttInfra::SendMail.new.valid? ).to be false
    ENV["SENDGRID_USER"] = 'sendgrid_user'
    expect( OttInfra::SendMail.new.valid? ).to be false
    ENV["SENDGRID_PASS"] = 'sendgrid_pass'
    expect( OttInfra::SendMail.new.valid? ).to be false
    ENV["SENDGRID_FROM"] = 'sendgrid_from'
    expect( OttInfra::SendMail.new.valid? ).to be true
  end
  it ".sendmail_options checks" do
    expected_hash = { api_user: "sendgrid_user",
                      api_key: "sendgrid_pass" }
    sendmail = OttInfra::SendMail.new
    expect( sendmail.send(:sendmail_options) ).to include( expected_hash )
  end
end
