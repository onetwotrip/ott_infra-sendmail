require 'spec_helper'

describe OttInfra::SendMail do
  before(:each) do
  end
  it 'check config instance variable' do
    sendmail = OttInfra::SendMail.new(sendgrid_user: 'user', sendgrid_pass: 'pass')
    expect(sendmail.config[:sendgrid_user]).to match('user')
    expect(sendmail.config[:sendgrid_pass]).to match('pass')
  end
  it '.sendmail_options checks' do
    expected_hash = { api_user: 'user', api_key: 'pass' }
    sendmail = OttInfra::SendMail.new(sendgrid_user: 'user', sendgrid_pass: 'pass')
    expect(sendmail.send(:sendmail_options)).to include(expected_hash)
  end

  it 'self.sendmail should run @client.send' do
    expect_any_instance_of(SendGrid::Client).to receive(:send).and_return(true)
    OttInfra::SendMail.sendmail(sendgrid_user: 'user', sendgrid_pass: 'pass')
  end
end
