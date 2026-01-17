Config = Config or {}

-- Set to true once you wire your economy functions
Config.UsePayments = false


Config.PaymentLabel = "Cash"


Config.CanAfford = function(source, amount)

  return true
end

Config.RemoveMoney = function(source, amount)

  return true
end
