import '../models/user_model.dart';

class Message1 {
  final User sender;
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool unread;

  Message1({
    this.sender,
    this.time,
    this.text,
    this.unread,
  });
}

// EXAMPLE CHATS ON HOME SCREEN
List<Message1> chats = [
  Message1(
    sender: ironMan,
    time: '5:30 PM',
    text: 'Hey dude! Even dead I\'m the hero. Love you 3000 guys.',
    unread: true,
  ),
  Message1(
    sender: captainAmerica,
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: true,
  ),
  Message1(
    sender: blackWindow,
    time: '3:30 PM',
    text: 'WOW! this soul world is amazing, but miss you guys.',
    unread: false,
  ),
  Message1(
    sender: spiderMan,
    time: '2:30 PM',
    text: 'I\'m exposed now. Please help me to hide my identity.',
    unread: true,
  ),
  Message1(
    sender: hulk,
    time: '1:30 PM',
    text: 'HULK SMASH!!',
    unread: false,
  ),
  Message1(
    sender: thor,
    time: '12:30 PM',
    text:
        'I\'m hitting gym bro. I\'m immune to mortal deseases. Are you coming?',
    unread: false,
  ),
  Message1(
    sender: scarletWitch,
    time: '11:30 AM',
    text: 'My twins are giving me headache. Give me some time please.',
    unread: false,
  ),
  Message1(
    sender: captainMarvel,
    time: '12:45 AM',
    text: 'You\'re always special to me nick! But you know my struggle.',
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message1> messages = [
  Message1(
    sender: ironMan,
    time: '5:30 PM',
    text: 'Hey dude! Event dead I\'m the hero. Love you 3000 guys.',
    unread: true,
  ),
  Message1(
    sender: currentUser,
    time: '4:30 PM',
    text: 'We could surely handle this mess much easily if you were here.',
    unread: true,
  ),
  Message1(
    sender: ironMan,
    time: '3:45 PM',
    text: 'Take care of peter. Give him all the protection & his aunt.',
    unread: true,
  ),
  Message1(
    sender: ironMan,
    time: '3:15 PM',
    text: 'I\'m always proud of her and blessed to have both of them.',
    unread: true,
  ),
  Message1(
    sender: currentUser,
    time: '2:30 PM',
    text:
        'But that spider kid is having some difficulties due his identity reveal by a blog called daily bugle.',
    unread: true,
  ),
  Message1(
    sender: currentUser,
    time: '2:30 PM',
    text:
        'Pepper & Morgan is fine. They\'re strong as you. Morgan is a very brave girl, one day she\'ll make you proud.',
    unread: true,
  ),
  Message1(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Yes Tony!',
    unread: true,
  ),
  Message1(
    sender: ironMan,
    time: '2:00 PM',
    text: 'I hope my family is doing well.',
    unread: true,
  ),
];
