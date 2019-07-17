module ContentQueries
  module_function
    def get_all_contents(params)
      query = <<-SQL.squish
        SELECT
          municipality_infos.city_id,
	        tar_city_infos.prefecture,
	        tar_city_infos.city,
	        tar_city_infos.ward,
	        tar_city_infos.category_id,
	        tar_city_infos.category_name,
	        municipality_infos.url,
	        municipality_infos.update_time,
	        municipality_infos.main_title,
	        municipality_infos.sub_title,
	        municipality_infos.content
        FROM
	        municipality_infos,
	        contents
	      INNER JOIN (
          SELECT
			      cities.prefecture,
			      cities.city,
			      cities.ward,
			      categories.city_id,
			      categories.category_id,
			      categories.category_name
		      FROM
			      cities,
			      categories
		      WHERE
			      cities.id = 1 AND
			      cities.id = categories.city_id
	      ) AS tar_city_infos ON contents.city_id = tar_city_infos.city_id AND contents.category = tar_city_infos.category_id
        WHERE
	        municipality_infos.city_id = contents.city_id AND
	        municipality_infos.url = contents.url AND
	        municipality_infos.category = contents.category AND
	        municipality_infos.main_title = contents.main_title
        ORDER BY
	        municipality_infos.city_id,
	        municipality_infos.category
      SQL

      sql = Content.sanitize_sql_array([query])
      Content.find_by_sql(sql)
    end

    def get_contents

    end
end