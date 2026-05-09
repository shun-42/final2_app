class ContactMailer < ApplicationMailer
  def send_notification(member,title,content)
    @title = title
    @content = content
    mail(
      to: member.email_address,
      subject: "New Event Notice: #{@title}"
    )
  end
end
