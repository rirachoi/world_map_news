content = [
  { 'Writing Fast Tests Against Enterprise Rails' => 60 },
  { 'Overdoing it in Python' => 45 },
  { 'Lua for the Masses' => 30 },
  { 'Ruby Errors from Mismatched Gem Versions' => 45 },
  { 'Common Ruby Errors' => 45 },
  { 'Rails for Python Developers lightning' => 5 },
  { 'Communicating Over Distance' => 60 },
  { 'Accounting-Driven Development' => 45 },
  { 'Woah' => 30 },
  { 'Sit Down and Write' => 30 },
  { 'Pair Programming vs Noise' => 45 },
  { 'Rails Magic' => 60 },
  { 'Ruby on Rails: Why We Should Move On' => 60 },
  { 'Clojure Ate Scala (on my project)' => 45 },
  { 'Programming in the Boondocks of Seattle' => 30 },
  { 'Ruby vs. Clojure for Back-End Development' => 30 },
  { 'Ruby on Rails Legacy App Maintenance' => 60 },
  { 'A World Without HackerNews' => 30 },
  { 'User Interface CSS in Rails Apps' => 30 }
]

track_1 = []
track_2 = []
track_no = 0

[track_1, track_2].each do |track| # Loop through two tracks

  [180, 240].each do |minutes| # Loop through morning and afternoon session

    session = [] # Initiate the morning session
    total_minutes = 0 # Initiate the accumulation of minutes

    remaining_minutes = 0 # Apparently, the total minutes in the content does not fit into the schedule perfectly
    content.each do |x| # So for the last session, we add up all the minutes in the content and check to see if the condition matches
      remaining_minutes += x.values.first # So for the last case, i.e. Track 2, Afternoon Session
    end

    if remaining_minutes < minutes
      minutes = remaining_minutes  # We reduce the minutes to what's left, which should be 210
    end

    until total_minutes >= minutes # Until the session hits 3 hours (9am - 12pm)
      talk = content.sample # We take a random talk out of the array
      unless content.empty?
        redo if session.include?(talk) # Just in case we already have the talk in the session, we redo the loop and get another one
      end
      session << talk # We push the talk into the session
      total_minutes += talk.values.first # Keeping count of the total minutes
      if total_minutes > minutes # However, if the total minutes exceeds 3 hours
        session.clear # We clear the session
        total_minutes = 0 # And the minutes
      end # And start the loop again
    end

    session.each do |talk| # Once the session is perfect,
      content.delete(talk) # We remove all the talks out of the content
    end

    content # Now, we're left with the remaining talks
    track << session # Append the session to the track
    track << { 'Lunch' => 60 } if minutes == 180 # Insert lunch after morning session
  end

  time = Time.new(2014, 9, 19, 9, 0, 0) # Initialize 9am start
  track_no += 1 # Counting Track number

  p "Track #{track_no}:" # Track Output

  track.flatten.each do |talk|
    p "#{time.strftime('%I:%M%p')} #{talk.keys.first}" # Using strftime to change the format
    time += (talk.values.first * 60) # Converting minutes to Time format and adding them
  end

  p '05:00PM Networking Event' # Last event in track

end