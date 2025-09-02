--// Marketplace Usage Example
--// How to use the marketplace automation system

--[[
CARA MENGGUNAKAN MARKETPLACE AUTOMATION:

1. SETUP AWAL:
   - Load main.lua untuk mendapatkan GUI
   - Marketplace tab akan tersedia di GUI
   - Konfigurasi settings sesuai kebutuhan

2. KONFIGURASI DASAR:
   - Max Spend Amount: Maksimal uang yang akan dihabiskan
   - Min Profit Margin: Minimum profit yang diinginkan (%)
   - Trading Strategy: Conservative/Balanced/Aggressive

3. FITUR UTAMA:

   a) AUTO TRADING:
      - Toggle "Auto Trading" untuk mulai sistem trading otomatis
      - Bot akan mencari peluang trading yang menguntungkan
      - Akan otomatis melakukan trade berdasarkan profit margin

   b) AUTO SHOPPING:
      - Toggle "Auto Shopping" untuk shopping otomatis
      - Bot akan monitor Daily Shop dan Shell Merchant
      - Beli item yang ada di auto-buy list atau item menguntungkan

   c) PRICE MONITORING:
      - Toggle "Price Monitoring" untuk monitor harga
      - Sistem akan track perubahan harga item
      - Alert ketika ada item dengan harga bagus

4. AUTO BUY SYSTEM:
   - Masukkan nama item di "Auto Buy Item"
   - Set max price di "Max Price"
   - Klik "Add to Auto Buy" untuk menambah ke list
   - Bot akan otomatis beli item tersebut jika harga <= max price

5. QUICK ACTIONS:
   - "Open Daily Shop": Buka daily shop secara manual
   - "Refresh Daily Shop": Refresh item daily shop
   - "Open Shell Merchant": Buka shell merchant
   - "Emergency Stop All": Stop semua automation sekaligus
   - "Show Status": Tampilkan status sistem

6. ADVANCED USAGE:
   
   -- Contoh script untuk auto buy item tertentu:
   if MarketplaceModule then
       -- Add multiple items to auto-buy list
       MarketplaceModule:AddToAutoBuyList("Megalodon", 4000)
       MarketplaceModule:AddToAutoBuyList("Kings Rod", 3500)
       MarketplaceModule:AddToAutoBuyList("Truffle Worm", 800)
       
       -- Set configuration
       MarketplaceModule:SetMaxSpendAmount(100000)
       MarketplaceModule:SetMinProfitMargin(0.20) -- 20% profit
       
       -- Start automation
       MarketplaceModule:StartAutoShopping()
       MarketplaceModule:StartPriceMonitoring()
   end

7. ITEM DATABASE:
   Sistem memiliki database item dengan harga base:
   - Megalodon: 5000 (base) -> 7500 (sell)
   - Great White Shark: 3000 -> 4500
   - Kings Rod: 5000 -> 7500
   - Heaven Rod: 8000 -> 12000
   - Fishing Yacht: 25000 -> 37500
   
8. TRADING STRATEGIES:
   
   Conservative:
   - Max spend: 30% dari total uang
   - Min profit: 25%
   - Risk: Low
   - Auto refresh: No
   
   Balanced:
   - Max spend: 50% dari total uang
   - Min profit: 20%
   - Risk: Medium
   - Auto refresh: Yes
   
   Aggressive:
   - Max spend: 70% dari total uang
   - Min profit: 15%
   - Risk: High
   - Auto refresh: Yes

9. SAFETY FEATURES:
   - Validation sebelum trading
   - Emergency stop function
   - Maximum spend limits
   - Profit margin checks
   - Price history tracking

10. TROUBLESHOOTING:
   - Jika error loading: cek file marketplace.lua ada di folder yang sama
   - Jika remote events error: game mungkin update structure
   - Jika auto buy tidak jalan: cek Max Spend Amount dan item price
   - Jika trade gagal: cek connection dan inventory space

11. TIPS PENGGUNAAN:
   - Start dengan Conservative strategy untuk safety
   - Monitor price history sebelum set auto-buy prices
   - Gunakan Emergency Stop jika ada yang aneh
   - Jangan set max spend terlalu tinggi di awal
   - Check status regularly untuk monitor performance

12. KEAMANAN:
   - Jangan share auto-buy list dengan pemain lain
   - Monitor aktivitas trading secara berkala
   - Backup item berharga sebelum auto trading
   - Set reasonable profit margins
   - Use emergency stop if suspicious activity detected

WARNING: Gunakan dengan bijak dan sesuai ToS game!
]]

-- Quick setup function
function SetupMarketplaceBot()
    if not MarketplaceModule then
        print("Marketplace module tidak loaded!")
        return
    end
    
    -- Conservative setup untuk pemula
    MarketplaceModule:SetMaxSpendAmount(50000) -- 50k max spend
    MarketplaceModule:SetMinProfitMargin(0.25) -- 25% profit minimum
    
    -- Add beberapa item profitable
    MarketplaceModule:AddToAutoBuyList("Truffle Worm", 800)
    MarketplaceModule:AddToAutoBuyList("Magnet", 400)
    MarketplaceModule:AddToAutoBuyList("Great White Shark", 2500)
    
    -- Start monitoring
    MarketplaceModule:StartPriceMonitoring()
    
    print("Marketplace bot setup complete! Use GUI untuk control.")
end

-- Run setup
-- SetupMarketplaceBot()

return "Marketplace Usage Guide Loaded"
