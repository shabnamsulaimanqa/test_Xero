#Code is to add items.
require "json"
require "selenium-webdriver"
gem "test-unit"
require "test/unit"
require "../test/base"

class XeroAdd < Test::Unit::TestCase

  def setup
    super
    @content_name = Time.new.to_i
     @item_code = Time.new.to_i # to insert unique item code
     @item_description = Time.new.to_i # to insert unique item code
         @date = Date.today()
    self.login($ADMIN_USER, $ADMIN_PASS)

  end
def home()
    @driver.get(@base_url)
  end

  def login(username, password)
    self.home()
     @driver.manage.timeouts.implicit_wait = 30
    self.set_text_value('#email', username, true)
    self.set_text_value('#password', password, true)
    self.click_when_clickable('#submitButton')

  end

  def test_xero_invoice
    sleep 5

 self.click_link_when_clickable('Reports', false, false) # to select Report tab
 sleep 5
self.click_link_when_clickable('All Reports', false, false)
 sleep 5
self.click_link_when_clickable('Accounts', false, false) # to select accounts tab
    sleep 5
    self.click_link_when_clickable('Sales', false, false) # to select sales
    sleep 5
    self.click_link_when_clickable('Dashboard', false, false) # to select sales

    sleep 5
  self.click_when_clickable('#keyAR')
        #to create three invoice
 self.set_text_value('div.invoicing-details input' ,"my value",true)
 self.set_text_value('#ext-gen38',  "#{@date}",true)
  self.set_text_value('#ext-gen44',  "#{@date+10}",true)
    $i=1
          $num=3
  self.set_text_value('#ext-comp-1002.x-form-textarea.x-form-field' ,"#{@item_code}",true) # to set item code
    self.set_text_value('#ext-gen67', "my description#{@item_description}", true) # To insert Desc in description field
     self.set_text_value('#ext-comp-1004' ,i,true) # to set Qty for an item 1..3
     self.set_text_value('#ext-gen85',"200",true)

          $i +=1

    self.click_when_clickable('a.words')
  end
  end
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end

  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end


