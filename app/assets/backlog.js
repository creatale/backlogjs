BacklogDB = {
  "name": "Mäuseparadies",
  "terms": [
    {
      "term": "Katze",
      "description": "Der Erzfeind aller Hausmäuse - je satter, desto ungefährlicher."
    },
    {
      "term": "Maus",
      "description": "Eine Hausmaus (Mus musculus), die in von Menschen bewohnten Häusern lebt."
    }
  ],
  "sprints": [
    {
      "id": 1,
      "start": "1815-12-09T23:00:00.000Z",
      "end": "1852-11-26T23:00:00.000Z"
    },
    {
      "id": 2,
      "start": "1815-12-27T23:00:00.000Z",
      "end": "1852-11-28T23:00:00.000Z"
    }
  ],
  "stories": [
    {
      "id": 1,
      "name": "Käse",
      "description": "Als Maus möchte ich ganz viel Käse im Kühlschrank haben, um immer satt und glücklich zu sein.",
      "requirements": [
        "1kg Käse im Kühlschrank"
      ],
      "process": [
        "Kühlschrank aufmachen",
        "Käse rausnehmen und wiegen",
        "Käse zurücklegen und Kühlschrank schließen"
      ],
      "priority": 1,
      "points": 42,
      "sprint": 1,
      "comments": [
        "Welche Sorte Käse?"
      ]
    },
    {
      "id": 2,
      "name": "Mauseloch",
      "description": "Als Maus möchte ich ein Mauseloch in der Wand haben, um vor der Katze sicher zu sein.",
      "requirements": [
        "Am Boden bündiges Loch in der Wand",
        "Lochdurchmesser 10cm",
        "Lochtiefe 15cm"
      ],
      "process": [
        "Maus ins Loch setzen",
        "Normhauskatze vor das Loch setzen",
        "Maus bleibt unversehrt"
      ],
      "priority": 5,
      "points": "13",
      "sprint": "2",
      "nonCommital": true
    },
    {
      "id": 3,
      "name": "Dekoration",
      "description": "Als Maus möchte ich eine schöne Einrichtung für mein Mauseloch, damit ich mich wohl fühle.",
      "requirements": [
        "Ein Bett im Mauseloch",
        "Ein Schrank im Mauseloch",
        "Ein Tisch im Mauseloch"
      ],
      "process": [
        "Rundgang durch das Mauseloch",
        "Bett zeigen",
        "Schrank zeigen",
        "Tisch zeigen"
      ],
      "dependencies": [
        2
      ],
      "priority": 10
    }
  ]
}