describe 'Music Library CLI' do

  it 'allows a user to list songs' do
    music_library_controller = MusicLibraryController.new("./spec/fixtures/mp3s")

    expect(MusicLibraryController).to receive(:new).and_return(music_library_controller)
    expect(music_library_controller).to receive(:gets).and_return("list songs", "exit")

    output = capture_puts {run_file("./bin/musiclibrary")}

    expect(output).to include("1. For Love I Come -- by Thundercat")
    expect(output).to include("2. Green Aisles -- by Real Estate")
    expect(output).to include("3. It's Real -- by Real Estate")
    expect(output).to include("4. Larry Csonka -- by Action Bronson")
  end

  it 'allows a user to list artists' do
    music_library_controller = MusicLibraryController.new("./spec/fixtures/mp3s")

    expect(MusicLibraryController).to receive(:new).and_return(music_library_controller)
    expect(music_library_controller).to receive(:gets).and_return("list artists", "exit")

    output = capture_puts {run_file("./bin/musiclibrary")}

    expect(output).to include("Action Bronson")
    expect(output).to include("Real Estate")
    expect(output).to include("Thundercat")
  end

  it 'allows a user to list genres' do
    music_library_controller = MusicLibraryController.new("./spec/fixtures/mp3s")

    expect(MusicLibraryController).to receive(:new).and_return(music_library_controller)
    expect(music_library_controller).to receive(:gets).and_return("list genres", "exit")

    output = capture_puts {run_file("./bin/musiclibrary")}

    expect(output).to include("indie")
    expect(output).to include("country")
    expect(output).to include("hip-hop")
    expect(output).to include("dance")
  end

  it 'allows a user to play a song' do
    music_library_controller = MusicLibraryController.new("./spec/fixtures/mp3s")

    expect(MusicLibraryController).to receive(:new).and_return(music_library_controller)
    expect(music_library_controller).to receive(:gets).and_return("play song", "1", "exit")

    output = capture_puts {run_file("./bin/musiclibrary")}

    expect(output).to include("Playing For Love I Come -- by Thundercat")
  end

  it 'allows a user to list an artist\'s songs' do
    music_library_controller = MusicLibraryController.new("./spec/fixtures/mp3s")

    expect(MusicLibraryController).to receive(:new).and_return(music_library_controller)
    expect(music_library_controller).to receive(:gets).and_return("show artist", "Real Estate", "exit")

    output = capture_puts {run_file("./bin/musiclibrary")}

    expect(output).to include("1. It's Real")
    expect(output).to include("2. Green Aisles")
  end

  it 'allows a user to list a genre\'s songs' do
    music_library_controller = MusicLibraryController.new("./spec/fixtures/mp3s")

    expect(MusicLibraryController).to receive(:new).and_return(music_library_controller)
    expect(music_library_controller).to receive(:gets).and_return("show genre", "dance", "exit")

    output = capture_puts {run_file("./bin/musiclibrary")}

    expect(output).to include("1. For Love I Come -- by Thundercat")
  end
end
