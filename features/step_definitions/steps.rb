Given(/^the program has finished$/) do
  # Test files are generated using iconv.
  @cucumber = `enlint examples/`
end

Then(/^the output is correct for each test$/) do
  lines = @cucumber.split("\n")

  expect(lines.length).to eq(1)

  expect(lines[0]).to match(%r(^examples/polite-russian.html\: observed iso-8859-1 preferred: \/\(utf-8|ascii\)/))
end
