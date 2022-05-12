//
//  Gibberish.swift
//  tiktok-tts
//
//  Created by Sophie Luna Schumann on 12.05.22.
//

import Foundation

public let Adjectives: [String] = [
    "appetizing",
    "aromatic",
    "distinctive",
    "fiery",
    "fragrant",
    "fresh",
    "hot",
    "peppery",
    "piquant",
    "savory",
    "seasoned",
    "sweet",
    "tangy",
    "tasty",
    "zesty",
    "ambrosial",
    "aromal",
    "flavorsome",
    "herbaceous",
    "highly seasoned",
    "keen",
    "odoriferous",
    "perfumed",
    "poignant",
    "racy",
    "redolent",
    "scented",
    "snappy",
    "spirited",
    "zippy",
]

public let Nouns: [String] = [
    "bi",
    "bisexual",
    "bisexual",
    "cishet",
    "closeted",
    "come out",
    "come out of the closet",
    "fag hag",
    "gay",
    "gay",
    "GLBT",
    "hetero",
    "hetero",
    "heterosexual",
    "heterosexual",
    "homoerotic",
    "homosexual",
    "homosexual",
    "lesbian",
    "LGB",
    "LGBT",
    "LGBTI",
    "LGBTIQ",
    "LGBTQ",
    "LGBTQ+",
    "LGBTQIA",
    "out",
    "out",
    "outing",
    "pansexual",
    "pansexuality",
    "pink",
    "the pink pound",
    "queer",
    "same-sex",
    "sapphic",
    "sexual orientation",
    "straight",
    "straight",
    "swing both ways",
]

public func GenerateGibberish() -> String {
    let giblets = Adjectives.randomElement()! + " " + Nouns.randomElement()!
    return giblets
}
