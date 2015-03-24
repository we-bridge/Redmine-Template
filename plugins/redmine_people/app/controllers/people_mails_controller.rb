class PeopleMailsController < ApplicationController
  unloadable


  def new
    @people = People.visible.find_all_by_id(params[:ids]).reject{|c| c.email.blank?}
    raise ActiveRecord::RecordNotFound if @people.empty?
    if !@people.collect{|c| c.send_mail_allowed?}.inject{|memo,d| memo && d}
      deny_access
      return
    end     
  end

  def create
    people = Contact.visible.find_all_by_id(params[:ids])
    raise ActiveRecord::RecordNotFound if people.empty?
    if !people.collect{|c| c.send_mail_allowed?}.inject{|memo,d| memo && d}
      deny_access 
      return
    end  
    raise_delivery_errors = ActionMailer::Base.raise_delivery_errors
    # Force ActionMailer to raise delivery errors so we can catch it
    ActionMailer::Base.raise_delivery_errors = true
    delivered_people = []
    error_people = []
    people.each do |contact|
      begin  
        params[:message] = mail_macro(contact, params[:"message-content"])
        ContactsMailer.bulk_mail(contact, params).deliver
        delivered_people << contact

        note = ContactNote.new
        note.subject = params[:subject]
        note.content = params[:message]
        note.author = User.current   
        note.type_id = Note.note_types[:email]
        contact.notes << note   
        Attachment.attach_files(note, params[:attachments])    
        render_attachment_warning_if_needed(note) 
        
      rescue Exception => e
        error_people << [contact, e.message]
      end
      flash[:notice] = l(:notice_email_sent, delivered_people.map{|c| "#{c.name} <span class='icon icon-email'>#{c.emails.first}</span>"}.join(', ')).chomp[0,500] if delivered_people.any?
      flash[:error] = l(:notice_email_error, error_people.map{|e| "#{e[0].name}: #{e[1]}"}.join(', ')).chomp[0,500] if error_people.any?
    end
    
    ActionMailer::Base.raise_delivery_errors = raise_delivery_errors
    redirect_back_or_default({:controller => 'people', :action => 'index', :project_id => @project})
  end  

  def preview_email
    @text = mail_macro(Contact.visible.first(:conditions => {:id  => params[:ids][0]}), params[:"message-content"])
    render :partial => 'common/preview'
  end  
end
