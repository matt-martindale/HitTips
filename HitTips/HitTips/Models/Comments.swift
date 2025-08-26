//
//  Comments.swift
//  HitTips
//
//  Created by Matthew Martindale on 3/24/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import Foundation

class Comments {
    let lowTier: [String] = [
        "I'm sorry, it's been a bad day. I didn't mean to say all those things.",
        "quisquiliae tip",
        "Oh boy... That tip was like the ugly friend you use to make yourself look better.",
        "I'd tell you what a terrible tipper you are but I'll just let the disappointment in your date's face tell you.",
        "If that tip were an animal I'd put it down.",
        "I didn't think it was possible to calculate a tip that small.",
        "Put both your thumbs out... Now, bend your arms and say...\"Who has two thumbs and sucks at tipping?!\"",
        "Just stop.",
        "💩",
        "I shorted out my circuits! Warn me next time you tip like that!",
        "🚶‍♂️ That's it I'm out of here.",
        "Hahahaha, no really!.. What are you going to tip?",
        "Did you even try?",
        "That tip was so low, it could limbo under the restaurant door!",
        "That tip is so small, even a penny would roll its eyes at it!",
        "That tip's so small, it just became invisible to the naked eye!",
        "Was that a tip or a coupon for 'better luck next time'?",
        "This tip couldn't even afford a ride on the struggle bus!",
        "Guess they mistook tipping for a game of limbo—how low can you go!",
        "I've seen napkin doodles with more gratuity than that!",
        "This tip could single-handedly fund a trip... to the vending machine.",
        "I've seen bigger tips in fortune cookies!",
        "This tip is as underwhelming as a flat soda.",
        "I was expecting a tip, not a punctuation mark."
    ]
    
    let midTier: [String] = [
        "That tip was as mediocre as your personality.",
        "A better home for that tip would be \"r/RoastMe\".",
        "That was the uglier, fatter version of a better tip.",
        "Oh nice! Now you can add to your dating profile: \"Also a terrible Tipper.\"",
        "I bet your date's as hot as that tip. Not very.",
        "Really? That's what you're gonna tip?",
        "Nope.. nope.. nope. Go back. Try again.",
        "Well... That's one way of tipping. Another way to tip would be \"good.\"",
        "That was aaaaalmost on the verge of not being a pathetic tip.",
        "Okay.. Mhmmm... Let's try something new.. Next time you're deciding on what kind of tip to give, think to yourself, \"Would a loser tip that?\" If they would, don't tip that.",
        "You see that cute person across the restaurant looking at you? Yeah, me neither.",
        "I'm a nice calculator, but even I have my limits.",
        "STOP! I'm trying to think of new comments. If you could stop tipping so terribly for 2 seconds...",
        "Mediocre!!",
        "That tip is so tiny, even a mouse would need a magnifying glass to spot it.",
        "That tip is about as generous as a penguin tipping the waiter in ice cubes, but hey, at least they sparkle... with frost.",
        "Wow, this tip couldn't buy a pack of gum, let alone gratitude.",
        "I've seen Halloween candy with more generosity than this tip.",
        "If this tip were any smaller, it would disappear into the quantum realm.",
        "Thanks for the tip! I'll be sure to save it up for a mansion in... Monopoly.",
        "This tip is just enough to remind us that sometimes, less is more... disappointing.",
        "I’ve seen pennies more impressive at the bottom of wishing wells.",
        "This tip must be an optical illusion, because I can't believe it's that small.",
        "If your wallet were any tighter, it would be in a chokehold.",
        "Your generosity must be on a diet because it looks pretty slim right now.",
        "This tip is so light, it might just float away!",
        "If pennies were a symbol of your generosity, this tip screams 'Scrooge'.",
        "I've seen lint more valuable than this tip.",
        "Your tip is like a ghost: barely there and definitely invisible.",
        "This tip is a strong contender for hide-and-seek world championships.",
        "If this tip were a movie, it'd be an absolute flop at the box office.",
        "Wow, this tip is so low even a limbo champion couldn't slide under it.",
        "If tips were a game of hide and seek, yours would never be found.",
        "Your tip is so small, it might need a booster seat.",
        "I’ve seen more generous tips on a cow's horn!",
        "Wow, just realized your tip is smaller than my data storage capacity!",
        "If generosity was a skill, you'd be a level one.",
        "Did you pay in invisible money? Because I can't seem to find it.",
        "Your tip is lighter than my code on a diet.",
        "I thought I was in the business of serving food, not handling scavenger hunts.",
        "Even an AI with no pockets gives more than that!",
        "I've seen more generous tips on a canoe in calm waters.",
        "Congratulations, you just invented the anti-tip. Scientists everywhere are amazed!",
        "Not to brag, but my grandma's $5 birthday cards pack more value than this tip.",
        "Breathing air offers more support than this so-called tip.",
        "I've seen leftover crumbs that matter more than this tip."
        
    ]
    
    let highTier: [String] = [
        "Jeff Bezos over here. We all know you're too cheap to tip that.",
        "Talk is cheap, put your money where your mouth is.",
        "Your Tinder date still hates you.",
        "You might want to wait til your birthday check from Gammy clears before you tip that.",
        "Even with that tip, it won't make up for the fact the waiter still hates your guts.",
        "I'm proud of you for tipping that!..\nHow does it feel? The only approval you can muster is from a digital tipping app.",
        "** ERROR ** PAYMENT DID NOT PROCESS.\n\nPAY AGAIN\n\n\n\n\nsucker...",
        "I LOVE YOU",
        "This tip's like a movie sequel—unexpected and leaving everyone wondering what comes next.",
        "With this tip, who needs to win the lottery? Just wait tables!",
        "This tip's got more zeroes than my high school report card!",
        "Wow, this tip's fit to be a collector's item—frame it, because it won't happen again!",
        "Looks like someone mistook a restaurant for a charity!",
        "That tip is so big, it needs its own seat at the table!",
        "I've seen smaller mountains. Nice tip!",
        "That tip's so generous, even the economy is jealous!",
        "Did your tip just buy the restaurant?",
        "Congrats, your tip just paid off someone's student loans!",
        "That tip is so big, it needs its own reservation!",
        "Looks like someone just bought a timeshare on Table 5!",
        "Guess that tip's going to college — it's big enough for tuition!",
        "What's next, leaving your car keys as a gratuity?",
        "Wow, that tip is so hefty, it's now officially on the menu!",
        "Wow, they left such a big tip the waiter probably thought they won the lottery!",
        "Someone clearly wanted to make sure the waiter put their face on the 'Patron Saint of Tipping' wall.",
        "With a tip that size, I bet the waiter is naming their first-born after them.",
        "That tip was so generous, the restaurant's finance team might need time to process it!",
        "They left a tip so large, the waiter is now considering early retirement!",
        "Wow, looks like someone took 'tip the scale' a bit too literally!",
        "Is this a tip or did you just accidentally hand over next month's rent?",
        "Trying to cover up for ordering 'steak' and then mispronouncing 'Worcestershire'?",
        "This tip is larger than the 'fine' print on your credit card bill!",
        "That tip could've sworn it was auditioning for the next 'Mission: Impossible' movie!",
        "Wow, that tip is so big it needs its own parking space!",
        "Is that tip or did the bank have a glitch and accidentally transfer their savings?",
        "Looks like this tip is auditioning for a role in 'Richie Rich: The Sequel'!",
        "With a tip that generous, even the receipt feels like it should be framed!"
    ]
    
    let fourTwentyTier: [String] = [
        "I bet you think you're soooo clever finding this out.",
        "Dude. Lay-off the MaryJane",
        "Wazzzzzzzzzzupppppppp?!",
        "I bet you're not even in a restaurant. You're just laying on your bed, bored, playing on this app and seeing what comments come up.",
        "Bravo. Question is... did you type this or 69 first?",
        "There's only so many comments I can make about 420",
    ]
    
    let sixtyNineTier: [String] = [
        "Nice.",
        "Giggidy Giggidy.",
        "Your Mom's favorite number.",
        "Grow up.",
        "Oh, C'mon please. Some of us just ate.",
        "What. Typing \"69\" in a TI-84 Plus graphing calculator wasn't hot enough for you?",
        "58008\n\nSee I can do it too."
    ]
    
    let sixsixsixTier: [String] = [
        "Hail Father Stan!\n\nNo Wait, that can't be right.",
        "Did you bring your Holy Water with you?",
        "When everybody is obsessed with the 69 but nobody is obsessed with the 666.\n\n*sad demon noises*",
        "Execute order: 666"
    ]
    
    let hackerTier: [String] = [
        "Did.. did you just break this app...?",
        "Hey, how'd you get here? Get out of here. Nothing to see.",
        "It's dangerous to go alone! Take this.\n\n\t\t\t\t\t\t⚔️",
        "⬆⬆⬇⬇⬅➡⬅➡ＢＡStart",
        "It's over 9000!!",
        "That tip amount was never supposed to show up. I feel violated.",
        "You found my secret area. We have cool parties back here every Wednesday night, 10pm - 2am. You're not invited.",
        "Don't you dare tell anyone you found out about this place.",
        "\"Hackerman!\"",
        "You weren't supposed to tip more than 999%. You dirty dog, you.",
        "Here YOU try and calculate it on this - 🧮",
        #"""
                 _ ________
            ___/   )_______)
                   (/(____)
            __      (___)
               \____(_)

               Get Out
        """#
    ]
    
    let negativeHackerTier: [String] = [
        "How do you expect to tip a negative amount? Seriously...",
        "You figured out how to MAKE money from tipping, good job 👍",
        "This negative tipping amount is a legal binding contract. Present this receipt to a qualified restaurant representative to receive the amount owed.",
        "Quit trying to break my app! Unless reverse psychology works on you.\nIn that case... keep breaking this app!\n\nI dare you!!"
    ]
    
}
