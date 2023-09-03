//
//  Realm+Extensions.swift
//  movies
//
//  Created by azun on 31/08/2023.
//

import RealmSwift
import Foundation

extension Realm {
    static func migrateIfNeeded() {
        guard let realm = try? Realm(),
              realm.objects(Movie.self).isEmpty else { return }
        
        try? realm.write {
            initialMovies.forEach {
                realm.add($0)
            }
        }
    }
}

// MARK: - Private
private extension Realm {
    static var initialMovies: [Movie] {
        let tenet = Movie()
        tenet.id = UUID().uuidString
        tenet.desc = "Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time."
        tenet.duration = 1 * 60 + 20

        let genres = List<Genre>()
        genres.append(.action)
        genres.append(.scifi)
        tenet.genres = genres

        tenet.rating = 7.8
        tenet.releasedDate = "3 September 2020".toDate()
        tenet.title = "Tenet"
        tenet.trailer = "https://www.youtube.com/watch?v=LdOM0x0XDMo"
        tenet.poster = "Tenet"
        
        let spiderMan = Movie()
        spiderMan.id = UUID().uuidString
        spiderMan.desc = "Teen Miles Morales becomes the Spider-Man of his universe, and must join with five spider-powered individuals from other dimensions to stop a threat for all realities."
        spiderMan.duration = 1 * 60 + 57

        genres.removeAll()
        genres.append(.action)
        genres.append(.animation)
        genres.append(.adventure)
        spiderMan.genres = genres

        spiderMan.rating = 8.4
        spiderMan.releasedDate = "14 December 2018".toDate()
        spiderMan.title = "Spider-Man: Into the Spider-Verse"
        spiderMan.trailer = "https://www.youtube.com/watch?v=tg52up16eq0"
        spiderMan.poster = "Spider Man"
        
        let knivesOut = Movie()
        knivesOut.id = UUID().uuidString
        knivesOut.desc = "A detective investigates the death of a patriarch of an eccentric, combative family."
        knivesOut.duration = 2 * 60 + 10

        genres.removeAll()
        genres.append(.comedy)
        genres.append(.crime)
        genres.append(.drama)
        knivesOut.genres = genres

        knivesOut.rating = 7.9
        knivesOut.releasedDate = "27 November 2019".toDate()
        knivesOut.title = "Knives Out"
        knivesOut.trailer = "https://www.youtube.com/watch?v=qGqiHJTsRkQ"
        knivesOut.poster = "Knives Out"
        
        let guardian = Movie()
        guardian.id = UUID().uuidString
        guardian.desc = "A group of intergalactic criminals must pull together to stop a fanatical warrior with plans to purge the universe."
        guardian.duration = 2 * 60 + 1

        genres.removeAll()
        genres.append(.action)
        genres.append(.adventure)
        genres.append(.comedy)
        guardian.genres = genres

        guardian.rating = 8.0
        guardian.releasedDate = "1 August 2014".toDate()
        guardian.title = "Guardians of the Galaxy"
        guardian.trailer = "https://www.youtube.com/watch?v=d96cjJhvlMA"
        guardian.poster = "Guardians of The Galaxy"
        
        let avenger = Movie()
        avenger.id = UUID().uuidString
        avenger.desc = "When Tony Stark and Bruce Banner try to jump-start a dormant peacekeeping program called Ultron, things go horribly wrong and it's up to Earth's mightiest heroes to stop the villainous Ultron from enacting his terrible plan."
        avenger.duration = 2 * 60 + 21
        
        genres.removeAll()
        genres.append(.action)
        genres.append(.adventure)
        genres.append(.scifi)
        avenger.genres = genres
        
        avenger.rating = 7.3
        avenger.releasedDate = "1 May 2015".toDate()
        avenger.title = "Avengers: Age of Ultron"
        avenger.trailer = "https://www.youtube.com/watch?v=tmeOjFno6Do"
        avenger.poster = "Avengers"
        
        return [tenet, spiderMan, knivesOut, guardian, avenger]
    }
}
