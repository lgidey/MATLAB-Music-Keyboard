clear
Instrument = input('Which instrument do you want? ');

%for Violin
if Instrument == 1
    clear
    rate = 44100;
    key = ' ';  %initialize note with a space
    duration=1;
    time=(0:1/rate:duration);
    RC=.2;
    decay=1-(exp(-time/RC));
    frequency = 220;

    keys = [97 115 100 102 103 104 106 107 108 59 39];
    % .     a . s   d . f . g . h . j . k . l . ;  '
    notes = [0 1 3 5 8 10 12 13  15 17 20];
    % A#3 f3 F#3 G#3 A#4 F4 F#4 G#4 C#4 D#4 C#5
    fourier = [0.1 0.25 0.07 0.03 0.06 0.09 0.02 0.14 0.13 0.07 0.02 0.03];
    v=zeros(1, length(time));

    while key ~='q' %while the keys being pressed are not q...
        key=char(getkey); %this lets you enter a key, this key value will eventually be found using the for loop, which will give us the note we want for that specific key
        for i=0:1:(length(keys)-1) %goes from 0 to length-1 of the getkey values of each key. it length-1 b/c we are starting at 0
            if key == keys(i+1) %if the character getkey value = to any one of the values in the keys vector...
            freq = frequency*2^(notes(i+1)/12);
                for x=1:1:length(fourier)
                    harmonic=(fourier(x)*sin(2*pi*freq*x*time));
                    v=v+harmonic;
                    note =v.*decay;
                end
            v=v/(max(v)*500); %normalize
            soundsc(note, rate)%play that note
            end %end if loop
        end %end for loop
     end %end while loop
%for pinao
elseif Instrument == 2
    clear
    rate = 44100;
    duration = 3; %how long the note will be played (seconds)
    time= (0:1/rate:duration); %time vector (0-1 seconds)
    RC = .2;
    decay= exp(-time/RC);%decay rate so it ends naturally

    f= [1 0.25 0.15 0.05]; %piano

    Am = [0 3 7];
    AmFreq = 220;
    A=zeros(1, length(time));
    Anote = zeros(1, length(time));
    for a=0:1:length(Am)-1
        frequency = AmFreq*2^(Am(a+1)/12);
            for x=1:1:length(f)
                harmonics=f(x)*sin(2*pi*frequency*x*time);
                Anote=Anote+harmonics;
            end
        note2 = decay.*Anote; %decays note naturally
        A=A+note2; % adds natural note to vector
    end
    A=A/(max(A)*2); %normalize!

    Em = [0 3 7];
    EmFreq = 164;
    B=zeros(1, length(time));
    Bnote = zeros(1, length(time));
    for b=1:1:length(Em)
        frequency = EmFreq*2^(Em(b)/12);
            for x=1:1:length(f)
                harmonics=f(x)*sin(2*pi*frequency*x*time);
                Bnote=Bnote+harmonics;
            end
        note4 = decay.*Bnote;
        B=B+note4;
    end
    B=B/(max(B)*2);


    F = [0 4 7];
    FFreq=174;
    C= zeros(1, length(time));
    Cnote = zeros(1, length(time));
    for c=1:1:length(F)
        frequency = FFreq*2^(F(c)/12);
            for x=1:1:length(f)
                harmonics=f(x)*sin(2*pi*frequency*x*time);
                Cnote=Cnote+harmonics;
            end
        note6 = decay.*Cnote;
        C=C+note6;
    end

    C=C/(max(C)*2);


    G = [0 4 7];
    GFreq = 196;
    D = zeros(1, length(time));
    Dnote = zeros(1, length(time));
    for d=1:1:length(G)
        frequency = GFreq*2^(G(d)/12);
            for x=1:1:length(f)
                harmonics=f(x)*sin(2*pi*frequency*x*time);
                Dnote=Dnote+harmonics;
            end
        note8 = decay.*Dnote;
        D=D+note8;
    end

    D=D/(max(D)*2);


    key = ' ';
    keys = [97 101 102 103];

    while key ~= 'q'
    key=char(getkey);
        if key == 'a'
            soundsc(A, rate);
        elseif key == 'e'
            soundsc(B, rate);
        elseif key == 'f'
            soundsc(C, rate);
        elseif key == 'g'
            soundsc(D, rate);
        end
    end
%for bass
elseif Instrument == 3
    clear
    rate = 44100;
    duration = .5; %in seconds
    time=(0:1/rate:duration); %time vector/arrays
    RC = 1.5;
    decay = (exp(-time/RC)); %decay growth envelope
    keys=[115 101 100 114 102];
    %keys = [s e d r f]
    key = ' ';  %initialize with space, this allows the user to enter a key

    notes = [1 3 4 9 11];
    b=zeros(1, length(time));
    fourier = [1 0.65 1.25 0.1 0.1 0.1 0 0 0.2];

    while key ~='q' %while the keys being pressed are not q...
        key=char(getkey); %this lets you enter a key, this key value will eventually be found using the for loop, which will give us the note we want for that specific key
        for i=0:1:(length(keys)-1) %goes from 0 to length-1 of the getkey values of each key. it length-1 b/c we are starting at 0
            if key == keys(i+1) %if the character getkey value = to any one of the values in the keysvector...
                frequency = 55*2^(notes(i+1)/12);
                  for x=1:1:length(fourier)
                    harmonic=fourier(x)*sin(2*pi*frequency*x*time);
                    b=b+harmonic;
                  end
            b=b/(max(b)*5); %normalize
            note=b.*decay;
            soundsc(note, rate);
            %play that note
            end %end if loop
        end %end for loop
     end %end while loop
%human vocal
elseif Instrument == 4
    %set up the parameters for the soundcard
    freq=44100; %samples per second
    bits=16;  %number of bits per sample
    mono=1;      %1=mono 2=stereo
    recordtime=5;  %total recording time, in seconds

    %set up the soundcard to record data and store the data to memory in the
    %variable called 'audio'
    recorder = audiorecorder(freq, bits, mono);
    recordblocking(recorder,recordtime);
    audio = getaudiodata(recorder);

    %play back the sampled sound and then wait 'recordtime+1' seconds
    soundsc(audio, freq);  %the command soundsc automatically SCALES the amplitude of the sample
    pause(recordtime+1);

end
