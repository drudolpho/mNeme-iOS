//
//  DeckCardViewController.swift
//  mNeme
//
//  Created by Dennis Rudolph on 2/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
class DeckCardViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var badRating: UIButton!
    @IBOutlet weak var okayRating: UIButton!
    @IBOutlet weak var greatRating: UIButton!
    @IBOutlet weak var nextCardButton: UIButton!
    @IBOutlet weak var wellKnownQuestion: UILabel!
    // MARK: - Variables
    private var frontLabel: UILabel?
    private var backLabel: UILabel?
    var deck: MockDemoDeck?
    var cards: [CardData] = []
    var currentCardInfo: CardInfo?
    var currentCardIndex: Int = 0
    var mockDemoDeckController = MockDemoDeckController()
    var allowedToFlip = true
    private var showingBack = false
    {
        didSet {
            if self.showingBack {
                showRatingStuff()
            } else {
                hideRatingStuff()
//                hideOtherLabels()
            }
        }
    }
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        frontLabel = UILabel(frame: CGRect(x: self.containerView.frame.width, y: self.containerView.frame.height, width: 80, height: 50))
        backLabel = UILabel(frame: CGRect(x: self.containerView.frame.width/1, y: self.containerView.frame.height/2, width: 80, height: 50))
        containerView.addSubview(frontLabel!)
        constrain(view: frontLabel!)
        //fetching deck data data
        deck = mockDemoDeckController.decodeMockData()
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(flip))
        singleTap.numberOfTapsRequired = 1
        containerView.addGestureRecognizer(singleTap)
        // Start setting up label logic
//        makeLabels()
        hideOtherLabels()
        updateDeckText()
    }
    // MARK: - IB Actions
    @IBAction func badRatingTapped(_ sender: Any) {
        ratingWasTapped()
    }
    @IBAction func okayRatingTapped(_ sender: Any) {
      ratingWasTapped()
    }
    @IBAction func greatRatingTapped(_ sender: Any) {
       ratingWasTapped()
    }
    @IBAction func nextCardButtonTapped(_ sender: Any) {
        currentCardIndex += 1
        allowedToFlip = true
        nextCardButton.isHidden = true
        flip()
        updateDeckText()
    }
    @objc func flip() {
        guard allowedToFlip == true else { return }
        let toView = showingBack ? frontLabel : backLabel
        let fromView = showingBack ? backLabel : frontLabel
        UIView.transition(from: fromView!, to: toView!, duration: 0.5, options: .transitionFlipFromRight, completion: nil)
        toView?.translatesAutoresizingMaskIntoConstraints = false
        constrain(view: toView!)
        showingBack = !showingBack
    }
    // MARK: - Private Functions
    private func updateDeckText() {
        let currentCardInfo = deck?.data[currentCardIndex].data
        frontLabel?.text = currentCardInfo?.front
        print("\(String(describing: currentCardInfo?.front))")
        backLabel?.text = currentCardInfo?.back
    }
//     private func flipUpdateDeckText() {
//           let currentCardInfo = deck?.data[currentCardIndex].data
//           frontLabel?.text = currentCardInfo?.back
//           print("\(String(describing: currentCardInfo?.front))")
//           backLabel?.text = currentCardInfo?.front
//       }
    private func makeLabels() {
        frontLabel = UILabel(frame: CGRect(x: self.containerView.frame.width, y: self.containerView.frame.height, width: 80, height: 50))
        backLabel = UILabel(frame: CGRect(x: self.containerView.frame.width/1, y: self.containerView.frame.height/2, width: 80, height: 50))
        containerView.addSubview(frontLabel!)
        containerView.addSubview(backLabel!)
        constrain(view: frontLabel!)
    }
    private func constrain(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let leadConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        let trailConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        self.containerView.addConstraints([horizontalConstraint, verticalConstraint, leadConstraint, trailConstraint])
    }
    private func ratingWasTapped() {
        wellKnownQuestion?.isHidden = true
        badRating?.isHidden = true
        okayRating?.isHidden = true
        greatRating?.isHidden = true
        nextCardButton?.isHidden = false
        allowedToFlip = false
    }
    private func hideOtherLabels() {
        nextCardButton?.isHidden = true
        wellKnownQuestion?.isHidden = true
        badRating?.isHidden = true
        okayRating?.isHidden = true
        greatRating?.isHidden = true
    }
    private func showRatingStuff() {
        wellKnownQuestion?.isHidden = false
        badRating?.isHidden = false
        okayRating?.isHidden = false
        greatRating?.isHidden = false
    }
    private func hideRatingStuff() {
        wellKnownQuestion?.isHidden = true
        badRating?.isHidden = true
        okayRating?.isHidden = true
        greatRating?.isHidden = true
       }
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
