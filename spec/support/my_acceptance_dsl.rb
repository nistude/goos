module MyAcceptanceDSL
  def self.included(base)
    base.instance_eval do
      alias :background :before
      alias :scenario :it
      alias :xscenario :xit
      alias :given :let
      alias :given! :let!
    end
  end
end

def self.feature(*args, &block)
  options = if args.last.is_a?(Hash) then args.pop else {} end
  options[:type] = :feature
  options[:caller] ||= caller
  args.push(options)

  describe(*args, &block)
end
