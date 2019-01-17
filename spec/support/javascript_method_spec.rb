# alert okクリック
def click_ok
  page.driver.browser.switch_to.alert.accept
end

# alert キャンセルクリック
def click_cancel
  page.driver.browser.switch_to.alert.dismiss
end

# alert text 取得
def get_text
  page.driver.browser.switch_to.alert.text
end
