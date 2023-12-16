json.extract! comment, :id, :content, :post_id, :commenter_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
