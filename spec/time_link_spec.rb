require 'time_link'

describe TimeLink do

  def time_link_for(time)
    time = Time.parse(time)
    TimeLink.build(time)
  end

  it 'transforms 12PM UTC into offset 0' do
    expect(time_link_for('2014-02-07 12:00:00 +0000')).to include('#2014-2-7,0,')
  end

  it 'transforms 12PM UTC+1 into offset -60' do
    expect(time_link_for('2014-02-07 12:00:00 +0100')).to include('#2014-2-7,-60,')
    expect(time_link_for('2014-02-07 11:00:00 +0000')).to include('#2014-2-7,-60,')
  end

  it 'transforms 12PM UTC-1 into offset +60' do
    expect(time_link_for('2014-02-07 12:00:00 -0100')).to include('#2014-2-7,60,')
    expect(time_link_for('2014-02-07 13:00:00 -0000')).to include('#2014-2-7,60,')
  end

  it 'requires a Time instance and not a string' do
    expect {
      TimeLink.build('2014-02-07 12:00:00 -0100')
    }.to raise_error ArgumentError
  end

  it 'builds a full link' do
    expect(time_link_for('2014-02-07 16:30:00 +0100')).to eq(
      "http://everytimezone.com/#2014-2-7,210,6bj")
  end

end