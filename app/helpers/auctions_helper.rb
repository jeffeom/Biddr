module AuctionsHelper
  def label_class(state)
    case state
    when "draft"
      "label-default"
    when "published"
      "label-primary"
    when "reserve_met"
      "label-success"
    when "won"
      "label-success"
    when "reserve_not_met"
      "label-danger"
    when "canceled"
      "label-danger"
    when "closed"
      "label-warning"
    end
  end
end
