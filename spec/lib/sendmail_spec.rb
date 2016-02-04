require "spec_helper"

describe OttInfra::SendMail do
  before(:each) do
  end
  it "check config instance variable" do
    sendmail = OttInfra::SendMail.new ({ from: 'from',
                                         user: 'user',
                                         pass: 'pass' })
    expect( sendmail.config[:sendgrid_user] ).to match( "user" )
    expect( sendmail.config[:sendgrid_pass] ).to match( "pass" )
    expect( sendmail.config[:sendgrid_from] ).to match( "from" )
  end
  it ".sendmail_options checks" do
    expected_hash = { api_user: "user",
                      api_key: "pass" }
    sendmail = OttInfra::SendMail.new ({ from: 'from',
                                         user: 'user',
                                         pass: 'pass' })
    expect( sendmail.send(:sendmail_options) ).to include( expected_hash )
  end
end
