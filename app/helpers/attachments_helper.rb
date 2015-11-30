module AttachmentsHelper
  def previewable?(attachment)
    attachment.csv? && attachment.attachable.is_a?(Edition)
  end

  # Until we have sensible (resourceful) routing for serving attachments, this method
  # provides a convenient shorthand for generating a path for attachment preview.
  def preview_path_for_attachment(attachment)
    preview_attachment_path(id: attachment.attachment_data.id, file: attachment.filename_without_extension, extension: attachment.file_extension)
  end
end
