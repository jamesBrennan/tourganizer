Fabricator :booking do
  stop
  start_time { Time.new(2013,12,1,20,0,0,'-08:00') }
  status { %w(offered confirmed).sample }
  details {
    {
      door: '$10',
      venue_name: 'Sweet Spirit',
      address: '123 Main Street, Springfield, OK'
    }
  }
end
