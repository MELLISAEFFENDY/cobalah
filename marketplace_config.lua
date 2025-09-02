--// Marketplace Configuration & Helper Functions
--// Extended functionality for marketplace automation

local MarketplaceConfig = {}

--// Item Database (Common valuable items in fishing games)
MarketplaceConfig.ItemDatabase = {
    -- Fish (High value/rare)
    ['Megalodon'] = {basePrice = 5000, rarity = 'Legendary', sellPrice = 7500},
    ['Great White Shark'] = {basePrice = 3000, rarity = 'Epic', sellPrice = 4500},
    ['Whale Shark'] = {basePrice = 2500, rarity = 'Epic', sellPrice = 3750},
    ['Golden Fish'] = {basePrice = 1500, rarity = 'Rare', sellPrice = 2250},
    ['Ancient Fish'] = {basePrice = 2000, rarity = 'Epic', sellPrice = 3000},
    
    -- Rods
    ['Mythical Rod'] = {basePrice = 10000, rarity = 'Mythical', sellPrice = 15000},
    ['Destiny Rod'] = {basePrice = 7500, rarity = 'Legendary', sellPrice = 11250},
    ['Kings Rod'] = {basePrice = 5000, rarity = 'Legendary', sellPrice = 7500},
    ['Heaven Rod'] = {basePrice = 8000, rarity = 'Legendary', sellPrice = 12000},
    
    -- Boats
    ['Luxury Boat'] = {basePrice = 15000, rarity = 'Epic', sellPrice = 22500},
    ['Speed Boat'] = {basePrice = 8000, rarity = 'Rare', sellPrice = 12000},
    ['Fishing Yacht'] = {basePrice = 25000, rarity = 'Legendary', sellPrice = 37500},
    
    -- Baits & Tools
    ['Magnet'] = {basePrice = 500, rarity = 'Common', sellPrice = 750},
    ['Truffle Worm'] = {basePrice = 1000, rarity = 'Rare', sellPrice = 1500},
    ['Rapid Catcher'] = {basePrice = 2000, rarity = 'Epic', sellPrice = 3000},
    
    -- Accessories
    ['Diving Gear'] = {basePrice = 3000, rarity = 'Rare', sellPrice = 4500},
    ['Flippers'] = {basePrice = 1500, rarity = 'Common', sellPrice = 2250},
    ['Oxygen Tank'] = {basePrice = 2500, rarity = 'Rare', sellPrice = 3750}
}

--// Trading Strategies
MarketplaceConfig.TradingStrategies = {
    Conservative = {
        maxSpendPercentage = 0.3, -- 30% of total money
        minProfitMargin = 0.25, -- 25% profit minimum
        riskLevel = 'Low',
        autoRefresh = false
    },
    Aggressive = {
        maxSpendPercentage = 0.7, -- 70% of total money
        minProfitMargin = 0.15, -- 15% profit minimum
        riskLevel = 'High',
        autoRefresh = true
    },
    Balanced = {
        maxSpendPercentage = 0.5, -- 50% of total money
        minProfitMargin = 0.20, -- 20% profit minimum
        riskLevel = 'Medium',
        autoRefresh = true
    }
}

--// Auto-Buy Lists (items to automatically purchase when seen at good prices)
MarketplaceConfig.AutoBuyPresets = {
    FishingFocus = {
        'Truffle Worm',
        'Magnet',
        'Rapid Catcher',
        'Kings Rod',
        'Heaven Rod'
    },
    ProfitFocus = {
        'Megalodon',
        'Great White Shark',
        'Ancient Fish',
        'Mythical Rod',
        'Fishing Yacht'
    },
    RarityFocus = {
        'Mythical Rod',
        'Destiny Rod',
        'Fishing Yacht',
        'Luxury Boat',
        'Diving Gear'
    }
}

--// Price Alert System
MarketplaceConfig.PriceAlerts = {
    enabled = true,
    alertThreshold = 0.20, -- Alert when item is 20% below normal price
    soundEnabled = true,
    chatNotification = true
}

--// Market Analysis Functions
function MarketplaceConfig:AnalyzeMarketTrends(priceHistory)
    local trends = {}
    
    for itemName, history in pairs(priceHistory) do
        if #history >= 5 then -- Need at least 5 data points
            local recentPrices = {}
            for i = math.max(1, #history - 4), #history do
                table.insert(recentPrices, history[i].price)
            end
            
            local avgRecent = 0
            for _, price in pairs(recentPrices) do
                avgRecent = avgRecent + price
            end
            avgRecent = avgRecent / #recentPrices
            
            local avgAll = 0
            for _, entry in pairs(history) do
                avgAll = avgAll + entry.price
            end
            avgAll = avgAll / #history
            
            trends[itemName] = {
                recentAverage = avgRecent,
                overallAverage = avgAll,
                trend = avgRecent > avgAll and 'Rising' or 'Falling',
                volatility = self:CalculateVolatility(recentPrices),
                recommendation = self:GetRecommendation(avgRecent, avgAll, itemName)
            }
        end
    end
    
    return trends
end

function MarketplaceConfig:CalculateVolatility(prices)
    if #prices < 2 then return 0 end
    
    local mean = 0
    for _, price in pairs(prices) do
        mean = mean + price
    end
    mean = mean / #prices
    
    local variance = 0
    for _, price in pairs(prices) do
        variance = variance + (price - mean)^2
    end
    variance = variance / #prices
    
    return math.sqrt(variance) / mean -- Coefficient of variation
end

function MarketplaceConfig:GetRecommendation(recentPrice, overallPrice, itemName)
    local itemData = self.ItemDatabase[itemName]
    if not itemData then return 'Hold' end
    
    local priceRatio = recentPrice / overallPrice
    local basePriceRatio = recentPrice / itemData.basePrice
    
    if priceRatio < 0.85 and basePriceRatio < 0.9 then
        return 'Strong Buy'
    elseif priceRatio < 0.95 and basePriceRatio < 1.1 then
        return 'Buy'
    elseif priceRatio > 1.15 and basePriceRatio > 1.3 then
        return 'Strong Sell'
    elseif priceRatio > 1.05 and basePriceRatio > 1.1 then
        return 'Sell'
    else
        return 'Hold'
    end
end

--// Advanced Trading Functions
function MarketplaceConfig:CreateTradingPlan(playerMoney, strategy)
    local plan = {}
    local strategyData = self.TradingStrategies[strategy] or self.TradingStrategies.Balanced
    
    plan.maxSpendAmount = playerMoney * strategyData.maxSpendPercentage
    plan.minProfitMargin = strategyData.minProfitMargin
    plan.riskLevel = strategyData.riskLevel
    plan.autoRefresh = strategyData.autoRefresh
    
    -- Generate buy targets based on strategy
    plan.buyTargets = {}
    for itemName, itemData in pairs(self.ItemDatabase) do
        local targetPrice = itemData.basePrice * (1 - strategyData.minProfitMargin)
        if targetPrice <= plan.maxSpendAmount * 0.1 then -- Max 10% of budget per item
            plan.buyTargets[itemName] = {
                maxPrice = targetPrice,
                priority = self:GetItemPriority(itemName, strategy),
                expectedProfit = itemData.sellPrice - targetPrice
            }
        end
    end
    
    return plan
end

function MarketplaceConfig:GetItemPriority(itemName, strategy)
    local itemData = self.ItemDatabase[itemName]
    if not itemData then return 1 end
    
    local rarityScores = {
        Common = 1,
        Rare = 2,
        Epic = 3,
        Legendary = 4,
        Mythical = 5
    }
    
    local profitRatio = itemData.sellPrice / itemData.basePrice
    local rarityScore = rarityScores[itemData.rarity] or 1
    
    if strategy == 'Conservative' then
        return rarityScore * 0.7 + profitRatio * 0.3
    elseif strategy == 'Aggressive' then
        return profitRatio * 0.7 + rarityScore * 0.3
    else -- Balanced
        return rarityScore * 0.5 + profitRatio * 0.5
    end
end

--// Market Notification System
function MarketplaceConfig:CreateNotification(title, message, alertType)
    local colors = {
        Success = Color3.fromRGB(0, 255, 0),
        Warning = Color3.fromRGB(255, 165, 0),
        Error = Color3.fromRGB(255, 0, 0),
        Info = Color3.fromRGB(0, 150, 255)
    }
    
    -- This would integrate with the game's notification system
    print(string.format("[%s] %s: %s", alertType, title, message))
    
    -- Could also create GUI notifications here
    return {
        title = title,
        message = message,
        type = alertType,
        color = colors[alertType] or colors.Info,
        timestamp = os.time()
    }
end

--// Trade Safety Functions
function MarketplaceConfig:ValidateTrade(offeredItems, requestedItems, playerMoney)
    local validation = {
        safe = true,
        warnings = {},
        offeredValue = 0,
        requestedValue = 0,
        profitMargin = 0
    }
    
    -- Calculate offered value
    for itemName, quantity in pairs(offeredItems) do
        local itemData = self.ItemDatabase[itemName]
        if itemData then
            validation.offeredValue = validation.offeredValue + (itemData.sellPrice * quantity)
        else
            table.insert(validation.warnings, "Unknown item: " .. itemName)
        end
    end
    
    -- Calculate requested value
    for itemName, quantity in pairs(requestedItems) do
        local itemData = self.ItemDatabase[itemName]
        if itemData then
            validation.requestedValue = validation.requestedValue + (itemData.basePrice * quantity)
        else
            table.insert(validation.warnings, "Unknown requested item: " .. itemName)
        end
    end
    
    -- Calculate profit margin
    if validation.requestedValue > 0 then
        validation.profitMargin = (validation.offeredValue - validation.requestedValue) / validation.requestedValue
    end
    
    -- Safety checks
    if validation.profitMargin < -0.1 then -- Losing more than 10%
        validation.safe = false
        table.insert(validation.warnings, "Trade shows significant loss")
    end
    
    if validation.requestedValue > playerMoney * 0.8 then -- Trading more than 80% of money
        validation.safe = false
        table.insert(validation.warnings, "Trading too much of your money")
    end
    
    return validation
end

--// Export configuration
return MarketplaceConfig
