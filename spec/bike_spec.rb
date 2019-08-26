require 'bike'

describe Bike do
  it { is_expected.to respond_to :working? }
  it { is_expected.to respond_to :broken }
  it { is_expected.to respond_to :fix }

  it 'reports a broken bike' do
    subject.broken
    expect(subject.working?).to be false
  end

  it 'fix the bike' do
    subject.broken
    subject.fix
    expect(subject.working?).to be true
  end
end
