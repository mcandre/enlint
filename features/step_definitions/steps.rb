Given(/^the program has finished$/) do
  # Test files are generated using iconv.

  @cucumber = `enlint examples/`
  @cucumber_ignore_html = `enlint -i '*.html' examples/`
  @cucumber_stat = `enlint -s examples/`
end

Then(/^the output is correct for each test$/) do
  lines = @cucumber.split("\n")

  expect(lines.length).to eq(2)

  expect(lines[0]).to match(
    %r(^examples/hello-wrong.bat\:.+$)
  )
  expect(lines[1]).to match(
    %r(^examples/polite-russian.html\:.+$)
  )


  lines_ignore_html = @cucumber_ignore_html.split("\n")

  expect(lines_ignore_html.length).to eq(1)

  expect(lines_ignore_html[0]).to match(
    %r(^examples/hello-wrong.bat\:.+$)
  )

  lines_stat = @cucumber_stat

  expect(valid_json?(lines_stat)).to eq(true)

  json = JSON.parse(lines_stat)

  expect(json['findings'].length).to eq(2)

  expect(json['findings'][0]['location']['path']).to match(
      'examples/hello-wrong.bat'
  )

  expect(json['findings'][1]['location']['path']).to match(
      'examples/polite-russian.html'
  )
end

def valid_json?(json)
  begin
    JSON.parse(json)
    return true
  rescue JSON::ParserError => e
    return false
  end
end
