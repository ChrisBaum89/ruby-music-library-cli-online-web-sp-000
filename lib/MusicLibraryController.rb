require 'pry'

class MusicLibraryController
  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    input = ""
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.strip
      if input == "list songs"
        list_songs
      elsif input == "list artists"
        list_artists
      elsif input == "list genres"
        list_genres
      elsif input == "list artist"
        list_songs_by_artist
      elsif input == "list genre"
        list_songs_by_genre
      elsif input == "play song"
        play_song
      end
    end
  end

  def list_songs
    count = 1
    sortedlist = Song.all.sort{|a, b| a.name <=> b.name}
    sortedlist.each do |song|
      puts "#{count}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      count += 1
    end
  end

  def list_artists
    count = 1
    sortedlist = Artist.all.sort{|a, b| a.name <=> b.name}
    sortedlist.each do |artist|
      puts "#{count}. #{artist.name}"
      count += 1
    end
  end

  def list_genres
    count = 1
    sortedlist = Genre.all.sort{|a, b| a.name <=> b.name}
    sortedlist.each do |genre|
      puts "#{count}. #{genre.name}"
      count += 1
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    count = 1
    if artist = Artist.find_by_name(input)
      sortedlist = artist.songs.sort{|a, b| a.name <=> b.name}
      sortedlist.each do |song|
        puts "#{count}. #{song.name} - #{song.genre.name}"
        count += 1
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    count = 1
    if genre = Genre.find_by_name(input)
      sortedlist = genre.songs.sort{|a, b| a.name <=> b.name}
      sortedlist.each do |song|
        puts "#{count}. #{song.artist.name} - #{song.name}"
        count += 1
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    sortedlist = Song.all.sort{|a, b| a.name <=> b.name}
    targetsong = sortedlist[input - 1]
    if input > 0 && input < sortedlist.count
      puts "Playing #{targetsong.name} by #{targetsong.artist.name}" unless not targetsong
    end
  end
end
