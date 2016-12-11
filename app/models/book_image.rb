class BookImage < ApplicationRecord

  has_attached_file :file, styles: { thumb: "300x", 
                                      big:   "800x" }
  validates_attachment :file, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end
