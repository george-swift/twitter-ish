module OpinionsHelper
  def delete(opinion)
    return unless current_user? opinion.author

    link_to opinion, method: :delete, data: { confirm: 'Delete your opinion?' } do
      image_tag('bin.png', class: 'top-icons', id: 'bin')
    end
  end
end
