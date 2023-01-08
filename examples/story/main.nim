from strutils import parseInt
import momo/dialogue

# TODO: WORKING ON IT ON IT!!!

#[
def gregory(content: str) -> Line:
  return text("Gregory", content)


def narrator(content: str) -> Line:
  return text("Narrator", content)


def god(content: str) -> Line:
  return text("You", content)

# A story made by Infdev and edited by AlexandrosKap.
d = Dialogue(
  [
    label("TOP"),
    narrator(
      """This is the story of a man named Gregory.
    Grigoris worked for a large company and today was a special day.
    He was chosen to pitch one of his ideas to the company.
    It was 09:30. He had a meeting at 10:00."""
      ),
      gregory("What should I do?"),
      menu("TEETH||GO", "Brush my teeth.||Go to the meeting."),
      label("GO"),
      gregory("I should go."),
      narrator(
        """Gregory opened the door and left.
      He thought that being early would make an impression.
      Unfortunately he forgot that being in your pajamas would also make an impression."""
        ),
        narrator(
          """After the meeting he heard people laughing.
        Probably because of his choice of clothes.
        He went home and slept the rest of the day.
        After he woke up, he thought, could I have done something different?"""
          ),
          jump("BSIDE"),
          label("TEETH"),
          narrator("Gregory brushed his teeth squeaky clean."),
          gregory("I still have 25 minutes. Now what?"),
          menu("SUIT||GO2||THINK", "Dress up.||Go to the meeting.||Think about life."),
          label("GO2"),
          narrator(
            """Gregory opened the door and left.
          He thought that being early would make an impression.
          Unfortunately he forgot that being in your pajamas would also make an impression."""
            ),
            narrator(
              """After the meeting he heard people laughing.
            Probably because of his choice of clothes.
            He went home and slept the rest of the day.
            After he woke up, he thought, could I have done something different?"""
              ),
              jump("BSIDE"),
              label("SUIT"),
              narrator("Gregory wore the fanciest suit he had."),
              gregory("Now what?"),
              menu("GO3||THINK", "Go to the meeting.||Think about life."),
              label("THINK"),
              gregory(
            """What am I doing with my life?
              Who am I? Why am I here???"""
        ),
        narrator("Gregory was going mental! He had to calm down right?"),
        menu("NEXT||GO3", "No.||Yes he should chill."),
        label("NEXT"),
        narrator(
            """Do you want him to continue?
Are you mad?
I mean... *cough*"""
        ),
        gregory(
            """Where do we go when we die?
Why do we exist as a species?
Is there a god?
Do I exist?"""
        ),
        menu(
            "NEXT2||GO4",
            "Thou shall continue.||OK, enough. Gregorius-Chillius!",
        ),
        label("NEXT2"),
        narrator(
            """You are a bad BAD person.
You stand behind your screen and laugh at an innocent man losing his bloody mind!
Who do you think you are?
People like you make me sick!"""
        ),
        gregory(
            """What are we, what are we?
You, up there.
Yes, I'm talking to you, the one behind the screen.
What am I, what am I?
I know you're listening.
Give me an answer."""
        ),
        menu("TRUTH||LIE", "Tell him the truth.||Lie about reality."),
        label("LIE"),
        god("Gregory... You have been in a coma for the past 5 years. Wake up."),
        narrator("Bro..."),
        gregory("I have to break free from this coma!"),
        gregory("Maybe stepping on a piece of lego will wake me up."),
        gregory("Real world here I come!"),
        narrator("Gregory NOOOOOO!!!"),
        narrator("..."),
        narrator("... let's try again."),
        jump("TOP"),
        label("TRUTH"),
        god("You are living in a simulation that is currently running on my computer."),
        gregory("What?"),
        gregory("Hey why is... everythin... go... b..."),
        gregory("..."),
        jump("TOP"),
        label("GO4"),
        narrator("Gregory snapped out of it."),
        gregory("What am I doing? I have a meeting to attend!"),
        narrator(
            """Gregory was 5 minutes late to the meeting.
After a long apology he started with the pitch.
The meeting went well.
At noon he went to a bar and he thought, could I have done something different?
"""
        ),
        jump("BSIDE"),
        label("GO3"),
        narrator(
            """Gregory went to the meeting on time.
The meeting was a success!"""
        ),
        gregory("Life is good."),
        gregory("I wonder, could I have done something different?"),
        label("BSIDE"),
        menu("END||TOP", "Nah.||Ye."),
        label("END"),
        narrator("Nah, he thought to himself."),
        narrator("The end."),
    ]
)
]#

when isMainModule:
  var story = newDialogue()
  while not story.hasPause:
    while story.hasMenu:
      for i, choice in story.choices:
        echo "-> ", i, ": ", choice
      var input = -1
      while input < 0 or input >= story.choices.len:
        try: input = readLine(stdin).parseInt
        except ValueError: discard
      story.choose(input)
    echo story.line.content
    story.update()
