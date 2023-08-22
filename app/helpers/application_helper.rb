module ApplicationHelper
<<<<<<< HEAD
<<<<<<< HEAD
=======
  def full_title page_title = ""
    base_title = t("base_title")
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
>>>>>>> c9f3aa9 (fix)
=======
  def full_title page_title = ""
    base_title = "Ruby on Rail Tutorial Sample App"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
>>>>>>> 9d35123 (Chapter 3_4_5 Add gem config Add i18n)
end
