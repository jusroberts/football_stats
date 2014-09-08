module StatsHelper
  def build_player_data(model)
    year = 2013
    array = []
    (0..model.range).each_with_index do |index|
      html = Nokogiri::HTML(open("#{model.url}#{year - index}"))
      yds = get_value_index(html, model.value)
      html.xpath('//table[@class="tablehead"]/tr').each do |tr|
        next if tr.attributes["class"].value == "colhead"
        name = tr.children[1].children[0].children[0].to_s
        player_index = find_index_by_name(array, name)
        if player_index == -1
          next if index != 0
          array = add_name_to_array(array, name)
          player_index = array.length - 1
        end

        array[player_index][:data]["#{year - index}"] = tr.children[yds].text.to_s.sub(',', '').to_i
      end
    end
    remove_non_latest_players(array, year)
  end

  private
  def find_index_by_name(array, name)
    array.each_with_index do |value, index|
      return index if value["name"] == name
    end
    return -1
  end

  def add_name_to_array(array, name)
    array << {"name" => name, data: {}}
  end

  def remove_non_latest_players(array, year)
    array.each do |entry|
      array.delete_at(array.index(entry)) if entry[:data]["#{year}"].nil?
    end
    array
  end

  def get_value_index(html, value)
    html.xpath('//table[@class="tablehead"]/tr')[0].children.each do |node|
      if node.text.downcase == value.downcase
        return html.xpath('//table[@class="tablehead"]/tr')[0].children.index(node)
      end
    end
  end
end
