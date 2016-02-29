# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[
  { code: "AL", name: "Alabama"},
  { code: "AK", name: "Alaska"},
  { code: "AZ", name: "Arizona"},
  { code: "AR", name: "Arkansas"},
  { code: "CA", name: "California"},
  { code: "CO", name: "Colorado"},
  { code: "CT", name: "Connecticut"},
  { code: "DE", name: "Delaware"},
  { code: "FL", name: "Florida"},
  { code: "GA", name: "Georgia"},
  { code: "HI", name: "Hawaii"},
  { code: "ID", name: "Idaho"},
  { code: "IL", name: "Illinois"},
  { code: "IN", name: "Indiana"},
  { code: "IA", name: "Iowa"},
  { code: "KS", name: "Kansas"},
  { code: "KY", name: "Kentucky"},
  { code: "LA", name: "Louisiana"},
  { code: "ME", name: "Maine"},
  { code: "MD", name: "Maryland"},
  { code: "MA", name: "Massachusetts"},
  { code: "MI", name: "Michigan"},
  { code: "MN", name: "Minnesota"},
  { code: "MS", name: "Mississippi"},
  { code: "MO", name: "Missouri"},
  { code: "MT", name: "Montana"},
  { code: "NE", name: "Nebraska"},
  { code: "NV", name: "Nevada"},
  { code: "NH", name: "New Hampshire"},
  { code: "NJ", name: "New Jersey"},
  { code: "NM", name: "New Mexico"},
  { code: "NY", name: "New York"},
  { code: "NC", name: "North Carolina"},
  { code: "ND", name: "North Dakota"},
  { code: "OH", name: "Ohio"},
  { code: "OK", name: "Oklahoma"},
  { code: "OR", name: "Oregon"},
  { code: "PA", name: "Pennsylvania"},
  { code: "RI", name: "Rhode Island"},
  { code: "SC", name: "South Carolina"},
  { code: "SD", name: "South Dakota"},
  { code: "TN", name: "Tennessee"},
  { code: "TX", name: "Texas"},
  { code: "UT", name: "Utah"},
  { code: "VT", name: "Vermont"},
  { code: "VA", name: "Virginia"},
  { code: "WA", name: "Washington"},
  { code: "WV", name: "West Virginia"},
  { code: "WI", name: "Wisconsin"},
  { code: "WY", name: "Wyoming"}
].each {|state| State.create code: state[:code], name: state[:name] }

User.create first_name: "John", last_name: "Wayne", email: "admin@example.com", password: "testing", role: User.roles[:admin], status: User.statuses[:active]

Agent.create comission: 3.0, phone: "1234567890", mobile: "1234567890", user_attributes: {first_name: "Robert", last_name: "Smith", email: "rob@example.com", password: "testing", role: User.roles[:agent], status: User.statuses[:active]}
Agent.create comission: 2.3, phone: "1234567890", mobile: "1234567890", user_attributes: {first_name: "Scott", last_name: "Weiland", email: "scott@example.com", password: "testing", role: User.roles[:agent], status: User.statuses[:active]}
Agent.create comission: 2.3, phone: "1234567890", mobile: "1234567890", user_attributes: {first_name: "Bryan", last_name: "Adams", email: "bryan@example.com", password: "testing", role: User.roles[:agent], status: User.statuses[:active]}
Agent.create comission: 2.3, phone: "1234567890", mobile: "1234567890", user_attributes: {first_name: "Paul", last_name: "McCartney", email: "paul@example.com", password: "testing", role: User.roles[:agent], status: User.statuses[:active]}
Agent.create comission: 2.3, phone: "1234567890", mobile: "1234567890", user_attributes: {first_name: "Eddie", last_name: "Vedder", email: "eddie@example.com", password: "testing", role: User.roles[:agent], status: User.statuses[:active]}
Agent.create comission: 2.3, phone: "1234567890", mobile: "1234567890", user_attributes: {first_name: "David", last_name: "Bowie", email: "david@example.com", password: "testing", role: User.roles[:agent], status: User.statuses[:active]}
Agent.create comission: 2.3, phone: "1234567890", mobile: "1234567890", user_attributes: {first_name: "Howie", last_name: "Day", email: "howie@example.com", password: "testing", role: User.roles[:agent], status: User.statuses[:active]}

Property.create title: "Beautiful Condo in Chicago", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et varius sem. Nulla nisi est, molestie a aliquet non, dignissim et augue. Cras imperdiet ex eget elit accumsan gravida. Duis nulla elit, ullamcorper eget ornare id, vehicula vel sem. Pellentesque nibh risus, placerat in iaculis a, aliquam at leo. Maecenas varius est odio, ut blandit nisi pharetra nec. Donec sollicitudin laoreet dolor id semper. Nulla congue nisi scelerisque nunc imperdiet, non pharetra sapien scelerisque. Aliquam convallis eros lobortis, fermentum libero at, posuere sem. ", photo: nil, price: 2400000.00, street_number: "800", street_name: "South Wells St.", city: "Chicago", state: State.find_by(code: "IL"), zipcode: "60607", suite: "412", agent: Agent.find(1), status: Property.statuses[:for_sale]

Property.create title: "Amazing View Condo (Chicago)", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et varius sem. Nulla nisi est, molestie a aliquet non, dignissim et augue. Cras imperdiet ex eget elit accumsan gravida. Duis nulla elit, ullamcorper eget ornare id, vehicula vel sem. Pellentesque nibh risus, placerat in iaculis a, aliquam at leo. Maecenas varius est odio, ut blandit nisi pharetra nec. Donec sollicitudin laoreet dolor id semper. Nulla congue nisi scelerisque nunc imperdiet, non pharetra sapien scelerisque. Aliquam convallis eros lobortis, fermentum libero at, posuere sem. ", photo: nil, price: 1800000.00, street_number: "1250", street_name: "S Indiana Ave", city: "Chicago", state: State.find_by(code: "IL"), zipcode: "60605", suite: "107", agent: Agent.find(1), status: Property.statuses[:sold]

Property.create title: "Chicago appartment near Wrigley Field", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et varius sem. Nulla nisi est, molestie a aliquet non, dignissim et augue. Cras imperdiet ex eget elit accumsan gravida. Duis nulla elit, ullamcorper eget ornare id, vehicula vel sem. Pellentesque nibh risus, placerat in iaculis a, aliquam at leo. Maecenas varius est odio, ut blandit nisi pharetra nec. Donec sollicitudin laoreet dolor id semper. Nulla congue nisi scelerisque nunc imperdiet, non pharetra sapien scelerisque. Aliquam convallis eros lobortis, fermentum libero at, posuere sem. ", photo: nil, price: 289000.00, street_number: "3413", street_name: "N Clark St", city: "Chicago", state: State.find_by(code: "IL"), zipcode: "60657", suite: "202", agent: Agent.find(1), status: Property.statuses[:for_sale]

Property.create title: "Beatiful new house in San Diego", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et varius sem. Nulla nisi est, molestie a aliquet non, dignissim et augue. Cras imperdiet ex eget elit accumsan gravida. Duis nulla elit, ullamcorper eget ornare id, vehicula vel sem. Pellentesque nibh risus, placerat in iaculis a, aliquam at leo. Maecenas varius est odio, ut blandit nisi pharetra nec. Donec sollicitudin laoreet dolor id semper. Nulla congue nisi scelerisque nunc imperdiet, non pharetra sapien scelerisque. Aliquam convallis eros lobortis, fermentum libero at, posuere sem. ", photo: nil, price: 289000.00, street_number: "15878", street_name: "Bass Ln", city: "San Diego", state: State.find_by(code: "CA"), zipcode: "92127", suite: nil, agent: Agent.find(2), status: Property.statuses[:for_sale]

Customer.create title: Customer.titles[:mrs], phone: "123456789", mobile: "1234567890", user_attributes: {first_name: "Jane", last_name: "Rogers", email: "jane@example.com", password: "testing", role: User.roles[:customer], status: User.statuses[:active]}