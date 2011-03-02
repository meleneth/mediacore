rails g scaffold Series name:string imdb_id:string synopsis:text
rails g scaffold Episode name:string episode_no:integer season_no:integer series_id:integer imdb_id:string original_air_date:date synopsis:text

