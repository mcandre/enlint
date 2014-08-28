Given(/^the program has finished$/) do
  # Test files are generated using iconv.

  @cucumber = `enlint examples/`
  @cucumber_ignore_html = `enlint -i \.html examples/`
end

Then(/^the output is correct for each test$/) do
  lines = @cucumber.split("\n")

  expect(lines.length).to eq(2)
  expect(lines[0]).to match(
    %r(^examples/polite-russian.html\:.+$)
  )

  lines_ignore_html = @cucumber_ignore_html.split("\n")

  expect(lines_ignore_html.length).to eq(1)
  expect(lines_ignore_html[0]).to match(
    %r(^examples/silly/ios7crypt.xml\:.+$)
  )
end
