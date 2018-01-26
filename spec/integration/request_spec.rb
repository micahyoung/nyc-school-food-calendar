require 'spec_helper'
require 'request_spec_helper'

describe 'Request' do
  it do
    response = get '/', params={month: '1', day: '26'}
    expect(response.body).to eq("")
  end
end
