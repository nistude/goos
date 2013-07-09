# Matchers that will wait for a value to change.

# Ex. expect { email.reload.delivered? }.to become_true
RSpec::Matchers.define :become_true do
  match do |block|
    begin
      Timeout.timeout(Capybara.default_wait_time) do
        sleep(0.1) until value = block.call
        value
      end
    rescue TimeoutError
      false
    end
  end
end

RSpec::Matchers.define :become_false do
  match do |block|
    begin
      Timeout.timeout(Capybara.default_wait_time) do
        sleep(0.1) until value = !block.call
        value
      end
    rescue TimeoutError
      false
    end
  end
end

# Ex. expect { page.current_url }.to become( '/#/something_or_other' )
RSpec::Matchers.define :become do |expected|
  match do |block|
    begin
      Timeout.timeout(Capybara.default_wait_time) do
        sleep(0.1) until value = ( block.call == expected )
        value
      end
    rescue TimeoutError
      false
    end
  end
end
