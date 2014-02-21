BacklogDB = {
  "stories": [
    {
      "id": 1,
      "name": "Käse",
      "description": "Als Maus möchte ich ganz viel Käse im Kühlschrank haben, um immer satt und glücklich zu sein.",
      "acceptanceTerms": [
        "1kg Käse im Kühlschrank"
      ],
      "scenario": [
        "Kühlschrank aufmachen",
        "Käse rausnehmen und wiegen",
        "Käse zurücklegen und Kühlschrank schließen"
      ],
      "priority": 999,
      "points": 42,
      "sprint": 1,
      "notes": [
        "Welche Sorte Käse?"
      ]
    },
    {
      "id": 2,
      "name": "Mauseloch",
      "description": "Als Maus möchte ich ein Mauseloch in der Wand haben, um vor der Katze sicher zu sein.",
      "acceptanceTerms": [
        "Am Boden bündiges Loch in der Wand",
        "Lochdurchmesser 10cm",
        "Lochtiefe 15cm"
      ],
      "scenario": [
        "Maus ins Loch setzen",
        "Normhauskatze vor das Loch setzen",
        "Maus bleibt unversehrt"
      ],
      "priority": 995,
      "points": 13,
      "sprint": 1
    },
    {
      "id": 3,
      "name": "Dekoration",
      "description": "Als Maus möchte ich eine schöne Einrichtung für mein Mauseloch, damit ich mich wohl fühle.",
      "acceptanceTerms": [
        "Ein Bett im Mauseloch",
        "Ein Schrank im Mauseloch",
        "Ein Tisch im Mauseloch"
      ],
      "scenario": [
        "Rundgang durch das Mauseloch",
        "Bett zeigen",
        "Schrank zeigen",
        "Tisch zeigen"
      ],
      "dependencies": [
        2
      ],
      "priority": 900,
      "estPoints": 20
    }
  ],
  "sprints": [{
      "id": 1,
      "start": "1815-12-09T23:00:00.000Z",
      "end": "1852-11-26T23:00:00.000Z"
  }],
  "terms": [
    {
      "term": "Maus",
      "explanation": "Eine Hausmaus (Mus musculus), die in von Menschen bewohnten Häusern lebt."
    },
    {
      "term": "Katze",
      "explanation": "Der Erzfeind aller Hausmäuse - je satter, desto ungefährlicher."
    }
  ]
}
