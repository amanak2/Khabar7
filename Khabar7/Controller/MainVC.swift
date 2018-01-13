//
//  ViewController.swift
//  Khabar7
//
//  Created by Aman Chawla on 23/12/17.
//  Copyright © 2017 Aman Chawla. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, HeadlineToNews, PhotoToPhotoVC, VideoToVideoVC, ProgramToProgramVC, OfflineTransfer  {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var latestNews: LatestNews!
    var photoNews: PhotoNews!
    var programNews: ProgramNews!
    var videoNews: VideoNews!
    
    var latest = [LatestNews]()
    var photo = [PhotoNews]()
    var program = [ProgramNews]()
    var video = [VideoNews]()
    
    var scrolling = [LatestNews]()
    var offlineData = [LatestNews]()
    var prevOfflineData = [OfflineData]()
    
    var transferToNewsVC = [LatestNews]()
    var transferToPhotoVC = [PhotoNews]()
    var transferToVideoVC = [VideoNews]()
    var transferToProgramVC = [ProgramNews]()
    var SingleNewsTransfer = [LatestNews]()
    
    var singleNewsToggle = false
    
    //Above Btns
    @IBOutlet weak var newNewsBtn: UIButton!
    @IBOutlet weak var mainNewsBtn: UIButton!
    @IBOutlet weak var stateNewsBtn: UIButton!
    @IBOutlet weak var worldNewsBtn: UIButton!
    @IBOutlet weak var sportsNewsBtn: UIButton!
    @IBOutlet weak var entertainmentNewsBtn: UIButton!
    
    //Below Btns
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var specialNewsBtn: UIButton!
    @IBOutlet weak var crimeNewsBtn: UIButton!
    @IBOutlet weak var healthNewsBtn: UIButton!
    @IBOutlet weak var careerNewsBtn: UIButton!
    @IBOutlet weak var prayerNewsBtn: UIButton!
    @IBOutlet weak var businessBtn: UIButton!
    
    
    var sideBarOpen = false
    @IBOutlet weak var sideBarConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getMainData()
        getScrollingData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let fetchRequest: NSFetchRequest<OfflineData> = OfflineData.fetchRequest()
        
        do {
            let offline = try PersistentService.context.fetch(fetchRequest)
            self.prevOfflineData = offline
        } catch { }
    }
    
    //MARK -- TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if singleNewsToggle == true {
            return latest.count
        } else if singleNewsToggle == false  {
            return 7
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 && singleNewsToggle == false {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineRow", for: indexPath) as? HeadlineRow {
                
                cell.latest = self.latest
                cell.collectionView.reloadData()
                cell.delegate = self
                cell.del = self
                
                return cell
            }
        } else if indexPath.row == 1 && singleNewsToggle == false {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoLabelCell") {
                
                return cell
            }
        } else if indexPath.row == 2 && singleNewsToggle == false {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoRow", for: indexPath) as? PhotoRow {
                
                cell.photo = self.photo
                cell.collectionView.reloadData()
                cell.delegate = self
                
                return cell
            }
        } else if indexPath.row == 3 && singleNewsToggle == false {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "VideoLabelCell") {
                
                return cell
            }
        } else if indexPath.row == 4 && singleNewsToggle == false {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "VideoRow", for: indexPath) as? VideoRow {
                
                cell.video = self.video
                cell.collectionView.reloadData()
                cell.delegate = self
                
                return cell
            }
        } else if indexPath.row == 5 && singleNewsToggle == false {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramLabelCell") {
                
                return cell
            }
        } else if indexPath.row == 6 && singleNewsToggle == false {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramRow", for: indexPath) as? ProgramRow {
                
                cell.program = self.program
                cell.collectionView.reloadData()
                cell.delegate = self
                
                return cell
            }
        } else if indexPath.row >= 7 && singleNewsToggle == true {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SingleNewsCell", for: indexPath) as? SingleNewsCell {
                
                let latest = self.latest[indexPath.row]
                cell.updateUI(singleNews: latest)
                
                tableView.allowsSelection = true 
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if singleNewsToggle == false {
            if indexPath.row == 0 {
                return 200
            } else if indexPath.row == 2 {
                return 120
            } else if indexPath.row == 4 {
                return 120
            } else if indexPath.row == 6 {
                return 120
            }
        } else if singleNewsToggle == true {
            if indexPath.row < 7 {
                return 0
            } else {
                return 120
            }
        }
        
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 7 {
            if let cell = tableView.cellForRow(at: indexPath) as? SingleNewsCell {
                self.SingleNewsTransfer = cell.SingleNewsTransfer
                performSegue(withIdentifier: "NewsFromSingleVC", sender: self)
            }
        }
    }
    
    //MARK -- CollectionView for Scrolling News
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scrolling.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScrollingNewsCell", for: indexPath) as? ScrollingNewsCell {
            
            let scrollingNews = self.scrolling[indexPath.section]
            cell.updateUI(scrollingNews: scrollingNews)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    //MARK -- Util
    
    func getMainData(){
        //LatestNews
        self.latest.removeAll()
        
        Alamofire.request("\(baseURL)news.php?category=uttar-pradesh").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let latest = LatestNews(getLatest: obj)
                    self.latest.append(latest)
                }
            }
            self.tableView.reloadData()
        }
        
        //ImageNews
        self.photo.removeAll()
        
        Alamofire.request("\(baseURL)newspics.php?category=uttar-pradesh").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let image = PhotoNews(getPhoto: obj)
                    self.photo.append(image)
                }
            }
            self.tableView.reloadData()
        }
        
        //VideoNews
        self.video.removeAll()
        
        Alamofire.request("\(baseURL)news_videos.php?category=uttar-pradesh").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let video = VideoNews(getVideo: obj)
                    self.video.append(video)
                }
            }
            self.tableView.reloadData()
        }
        
        //ProgramNews
        self.program.removeAll()
        
        Alamofire.request("\(baseURL)news_list.php?id=30").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let program = ProgramNews(getProgram: obj)
                    self.program.append(program)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func getScrollingData() {
        self.scrolling.removeAll()
        
        Alamofire.request("\(baseURL)news.php?category=crime").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let scrollingNews = LatestNews(getLatest: obj)
                    self.scrolling.append(scrollingNews)
                }
            }
            self.collectionView.reloadData()
        }
    }
    
    //MARK -- Segues
    
    func pushToNewsVC(latestNews: [LatestNews]) {
        self.transferToNewsVC = latestNews
        performSegue(withIdentifier: "NewsVC", sender: self)
    }
    
    func pushToPhotoVC(photoNews: [PhotoNews]) {
        self.transferToPhotoVC = photoNews
        performSegue(withIdentifier: "PhotoVC", sender: self)
    }
    
    func pushToVideoVC(videoNews: [VideoNews]) {
        self.transferToVideoVC = videoNews
        performSegue(withIdentifier: "VideoVC", sender: self)
    }
    
    func pushToProgramVC(programNews: [ProgramNews]) {
        self.transferToProgramVC = programNews
        performSegue(withIdentifier: "ProgramVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsFromSingleVC" {
            if let destination = segue.destination as? NewsFromSingleVC  {
                destination.news = self.SingleNewsTransfer
            }
        } else if segue.identifier == "NewsVC" {
            if let destination = segue.destination as? NewsVC  {
                destination.latestNews = self.transferToNewsVC
                destination.SuggestedLatestNews = self.latest
            }
        } else if segue.identifier == "PhotoVC" {
            if let destination = segue.destination as? PhotoVC {
                destination.photoNews = self.transferToPhotoVC
            }
        } else if segue.identifier == "VideoVC" {
            if let destination = segue.destination as? VideoVC {
                destination.videoNews = self.transferToVideoVC
                destination.SuggestedNews = self.video
            }
        } else if segue.identifier == "ProgramVC" {
            if let destination = segue.destination as? NewsVC {
                destination.programNews = self.transferToProgramVC
                destination.SuggestedProgramNews = self.program
            }
        }
    }
    
    @IBAction func BreakingNewsBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "BreakingNewsVC", sender: nil)
    }
    
    
    //MARK -- SideBar Menu
    @IBAction func sideBarBtnPressed(_ sender: Any) {
        if sideBarOpen == false {
            sideBarConstraint.constant = 0
            sideBarOpen = true
        } else if sideBarOpen == true {
            sideBarConstraint.constant = -180
            sideBarOpen = false 
        }
    }
    
    //MARK -- OfflineNews Handling
    
    func transferOfflineData(news: [LatestNews]) {
        self.offlineData.removeAll()
        self.offlineData = news
        
        let offline = OfflineData(context: PersistentService.context)
        
        offline.id = Int64((self.offlineData.first?.id)!)
        offline.link = Int64((self.offlineData.first?.link)!)
        offline.category = (self.offlineData.first?.category)!
        offline.tag = (self.offlineData.first?.tag)!
        offline.headline = (self.offlineData.first?.headline)!
        offline.story = (self.offlineData.first?.story)!
        offline.sub_story = (self.offlineData.first?.sub_story)!
        offline.video_url = (self.offlineData.first?.video_url)!
        offline.thumbnail = (self.offlineData.first?.thumbnail)!
        offline.onhomepage = (self.offlineData.first?.onhomepage)!
        offline.edited_by = (self.offlineData.first?.edited_by)!
        offline.time = (self.offlineData.first?.time)!
        offline.date = (self.offlineData.first?.date)!
        offline.location = (self.offlineData.first?.location)!
        offline.update = (self.offlineData.first?.update)!
        offline.app_img = (self.offlineData.first?.app_img)!
        
        PersistentService.saveContext()
    }
    
    //MARK -- SideBar Buttons
    
    @IBAction func sideHomeBtnPressed(_ sender: Any) {
       homeNewsBtnPressed(self)
    }
    
    @IBAction func sideLivetvBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func sidePhotoBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func sideVideoBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func sideOfflineBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "OfflineVC", sender: nil)
    }
    
    @IBAction func sideRateBtnPressed(_ sender: Any) {
        rateApp(appId: "id959379869") { success in
            print("RateApp \(success)")
        }
    }
    
    @IBAction func sideShareBtnPressed(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["APP LINK GOES HERE"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
    
    //MARK -- Above TableView Menu
    
    @IBAction func newNewsBtnPressed(_ sender: Any) {
        singleNewsToggle = false
        
        newNewsBtn.backgroundColor = UIColor.lightGray
        mainNewsBtn.backgroundColor = UIColor.clear
        stateNewsBtn.backgroundColor = UIColor.clear
        worldNewsBtn.backgroundColor = UIColor.clear
        sportsNewsBtn.backgroundColor = UIColor.clear
        entertainmentNewsBtn.backgroundColor = UIColor.clear
        
        homeBtn.backgroundColor = UIColor.clear
        specialNewsBtn.backgroundColor = UIColor.clear
        crimeNewsBtn.backgroundColor = UIColor.clear
        healthNewsBtn.backgroundColor = UIColor.clear
        careerNewsBtn.backgroundColor = UIColor.clear
        prayerNewsBtn.backgroundColor = UIColor.clear
        businessBtn.backgroundColor = UIColor.clear
        
        //LatestNews
        self.latest.removeAll()
        
        Alamofire.request("\(baseURL)news.php?category=uttar-pradesh").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let latest = LatestNews(getLatest: obj)
                    self.latest.append(latest)
                }
            }
            self.tableView.reloadData()
        }
        
        //ImageNews
        self.photo.removeAll()
        
        Alamofire.request("\(baseURL)newspics.php?category=uttra-khand").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let image = PhotoNews(getPhoto: obj)
                    self.photo.append(image)
                }
            }
            self.tableView.reloadData()
        }
        
        //VideoNews
        self.video.removeAll()
        
        Alamofire.request("\(baseURL)news_videos.php?category=uttar-pradesh").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let video = VideoNews(getVideo: obj)
                    self.video.append(video)
                }
            }
            self.tableView.reloadData()
        }
        
        //ProgramNews
        self.program.removeAll()
        
        Alamofire.request("\(baseURL)news_list.php?id=30").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let program = ProgramNews(getProgram: obj)
                    self.program.append(program)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func mainNewsBtnPressed(_ sender: Any) {
        singleNewsToggle = false
        
        newNewsBtn.backgroundColor = UIColor.clear
        mainNewsBtn.backgroundColor = UIColor.lightGray
        stateNewsBtn.backgroundColor = UIColor.clear
        worldNewsBtn.backgroundColor = UIColor.clear
        sportsNewsBtn.backgroundColor = UIColor.clear
        entertainmentNewsBtn.backgroundColor = UIColor.clear
        
        homeBtn.backgroundColor = UIColor.clear
        specialNewsBtn.backgroundColor = UIColor.clear
        crimeNewsBtn.backgroundColor = UIColor.clear
        healthNewsBtn.backgroundColor = UIColor.clear
        careerNewsBtn.backgroundColor = UIColor.clear
        prayerNewsBtn.backgroundColor = UIColor.clear
        businessBtn.backgroundColor = UIColor.clear
        
        //LatestNews
        self.latest.removeAll()
        
        Alamofire.request("\(baseURL)news.php?category=desh").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let latest = LatestNews(getLatest: obj)
                    self.latest.append(latest)
                }
            }
            self.tableView.reloadData()
        }
        
        //ImageNews
        self.photo.removeAll()
        
        Alamofire.request("\(baseURL)newspics.php?category=desh").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let image = PhotoNews(getPhoto: obj)
                    self.photo.append(image)
                }
            }
            self.tableView.reloadData()
        }
        
        //VideoNews
        self.video.removeAll()
        
        Alamofire.request("\(baseURL)news_videos.php?category=desh").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let video = VideoNews(getVideo: obj)
                    self.video.append(video)
                }
            }
            self.tableView.reloadData()
        }
        
        //ProgramNews
        self.program.removeAll()
        
        Alamofire.request("\(baseURL)news_list.php?id=33").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let program = ProgramNews(getProgram: obj)
                    self.program.append(program)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func stateNewsBtnPressed(_ sender: Any) {
        singleNewsToggle = false
        
        newNewsBtn.backgroundColor = UIColor.clear
        mainNewsBtn.backgroundColor = UIColor.clear
        stateNewsBtn.backgroundColor = UIColor.lightGray
        worldNewsBtn.backgroundColor = UIColor.clear
        sportsNewsBtn.backgroundColor = UIColor.clear
        entertainmentNewsBtn.backgroundColor = UIColor.clear
        
        homeBtn.backgroundColor = UIColor.clear
        specialNewsBtn.backgroundColor = UIColor.clear
        crimeNewsBtn.backgroundColor = UIColor.clear
        healthNewsBtn.backgroundColor = UIColor.clear
        careerNewsBtn.backgroundColor = UIColor.clear
        prayerNewsBtn.backgroundColor = UIColor.clear
        businessBtn.backgroundColor = UIColor.clear
        
        //LatestNews
        self.latest.removeAll()
        
        Alamofire.request("\(baseURL)news.php?category=uttra-khand").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let latest = LatestNews(getLatest: obj)
                    self.latest.append(latest)
                }
            }
            self.tableView.reloadData()
        }
        
        //ImageNews
        self.photo.removeAll()
        
        Alamofire.request("\(baseURL)newspics.php?category=uttra-khand").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let image = PhotoNews(getPhoto: obj)
                    self.photo.append(image)
                }
            }
            self.tableView.reloadData()
        }
        
        //VideoNews
        self.video.removeAll()
        
        Alamofire.request("\(baseURL)news_videos.php?category=uttra-khand").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let video = VideoNews(getVideo: obj)
                    self.video.append(video)
                }
            }
            self.tableView.reloadData()
        }
        
        //ProgramNews
        self.program.removeAll()
        
        Alamofire.request("\(baseURL)news_list.php?id=30").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let program = ProgramNews(getProgram: obj)
                    self.program.append(program)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func worldNewsBtnPressed(_ sender: Any) {
        singleNewsToggle = false
        
        newNewsBtn.backgroundColor = UIColor.clear
        mainNewsBtn.backgroundColor = UIColor.clear
        stateNewsBtn.backgroundColor = UIColor.clear
        worldNewsBtn.backgroundColor = UIColor.lightGray
        sportsNewsBtn.backgroundColor = UIColor.clear
        entertainmentNewsBtn.backgroundColor = UIColor.clear
        
        homeBtn.backgroundColor = UIColor.clear
        specialNewsBtn.backgroundColor = UIColor.clear
        crimeNewsBtn.backgroundColor = UIColor.clear
        healthNewsBtn.backgroundColor = UIColor.clear
        careerNewsBtn.backgroundColor = UIColor.clear
        prayerNewsBtn.backgroundColor = UIColor.clear
        businessBtn.backgroundColor = UIColor.clear
        
        //LatestNews
        self.latest.removeAll()
        
        Alamofire.request("\(baseURL)news.php?category=duniya").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let latest = LatestNews(getLatest: obj)
                    self.latest.append(latest)
                }
            }
            self.tableView.reloadData()
        }
        
        //ImageNews
        self.photo.removeAll()
        
        Alamofire.request("\(baseURL)newspics.php?category=duniya").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let image = PhotoNews(getPhoto: obj)
                    self.photo.append(image)
                }
            }
            self.tableView.reloadData()
        }
        
        //VideoNews
        self.video.removeAll()
        
        Alamofire.request("\(baseURL)news_videos.php?category=duniya").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let video = VideoNews(getVideo: obj)
                    self.video.append(video)
                }
            }
            self.tableView.reloadData()
        }
        
        //ProgramNews
        self.program.removeAll()
        
        Alamofire.request("\(baseURL)news_list.php?id=33").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let program = ProgramNews(getProgram: obj)
                    self.program.append(program)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func sportsNewsBtnPressed(_ sender: Any) {
        singleNewsToggle = false
        
        newNewsBtn.backgroundColor = UIColor.clear
        mainNewsBtn.backgroundColor = UIColor.clear
        stateNewsBtn.backgroundColor = UIColor.clear
        worldNewsBtn.backgroundColor = UIColor.clear
        sportsNewsBtn.backgroundColor = UIColor.lightGray
        entertainmentNewsBtn.backgroundColor = UIColor.clear
        
        homeBtn.backgroundColor = UIColor.clear
        specialNewsBtn.backgroundColor = UIColor.clear
        crimeNewsBtn.backgroundColor = UIColor.clear
        healthNewsBtn.backgroundColor = UIColor.clear
        careerNewsBtn.backgroundColor = UIColor.clear
        prayerNewsBtn.backgroundColor = UIColor.clear
        businessBtn.backgroundColor = UIColor.clear
        
        //LatestNews
        self.latest.removeAll()
        
        Alamofire.request("\(baseURL)news.php?category=khel").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let latest = LatestNews(getLatest: obj)
                    self.latest.append(latest)
                }
            }
            self.tableView.reloadData()
        }
        
        //ImageNews
        self.photo.removeAll()
        
        Alamofire.request("\(baseURL)newspics.php?category=khel").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let image = PhotoNews(getPhoto: obj)
                    self.photo.append(image)
                }
            }
            self.tableView.reloadData()
        }
        
        //VideoNews
        self.video.removeAll()
        
        Alamofire.request("\(baseURL)news_videos.php?category=khel").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let video = VideoNews(getVideo: obj)
                    self.video.append(video)
                }
            }
            self.tableView.reloadData()
        }
        
        //ProgramNews
        self.program.removeAll()
        
        Alamofire.request("\(baseURL)news_list.php?id=33").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let program = ProgramNews(getProgram: obj)
                    self.program.append(program)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func entertainmentNewsBtnPressed(_ sender: Any) {
        singleNewsToggle = false
        
        newNewsBtn.backgroundColor = UIColor.clear
        mainNewsBtn.backgroundColor = UIColor.clear
        stateNewsBtn.backgroundColor = UIColor.clear
        worldNewsBtn.backgroundColor = UIColor.clear
        sportsNewsBtn.backgroundColor = UIColor.clear
        entertainmentNewsBtn.backgroundColor = UIColor.lightGray
        
        homeBtn.backgroundColor = UIColor.clear
        specialNewsBtn.backgroundColor = UIColor.clear
        crimeNewsBtn.backgroundColor = UIColor.clear
        healthNewsBtn.backgroundColor = UIColor.clear
        careerNewsBtn.backgroundColor = UIColor.clear
        prayerNewsBtn.backgroundColor = UIColor.clear
        businessBtn.backgroundColor = UIColor.clear
        
        //LatestNews
        self.latest.removeAll()
        
        Alamofire.request("\(baseURL)news.php?category=manoranjan").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let latest = LatestNews(getLatest: obj)
                    self.latest.append(latest)
                }
            }
            self.tableView.reloadData()
        }
        
        //ImageNews
        self.photo.removeAll()
        
        Alamofire.request("\(baseURL)newspics.php?category=manoranjan").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let image = PhotoNews(getPhoto: obj)
                    self.photo.append(image)
                }
            }
            self.tableView.reloadData()
        }
        
        //VideoNews
        self.video.removeAll()
        
        Alamofire.request("\(baseURL)news_videos.php?category=manoranjan").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let video = VideoNews(getVideo: obj)
                    self.video.append(video)
                }
            }
            self.tableView.reloadData()
        }
        
        //ProgramNews
        self.program.removeAll()
        
        Alamofire.request("\(baseURL)news_list.php?id=33").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let program = ProgramNews(getProgram: obj)
                    self.program.append(program)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    //MARK -- Below TableView Menu
    
    @IBAction func homeNewsBtnPressed(_ sender: Any) {
        singleNewsToggle = false
        
        newNewsBtn.backgroundColor = UIColor.clear
        mainNewsBtn.backgroundColor = UIColor.clear
        stateNewsBtn.backgroundColor = UIColor.clear
        worldNewsBtn.backgroundColor = UIColor.clear
        sportsNewsBtn.backgroundColor = UIColor.clear
        entertainmentNewsBtn.backgroundColor = UIColor.clear
        
        homeBtn.backgroundColor = UIColor.red
        specialNewsBtn.backgroundColor = UIColor.clear
        crimeNewsBtn.backgroundColor = UIColor.clear
        healthNewsBtn.backgroundColor = UIColor.clear
        careerNewsBtn.backgroundColor = UIColor.clear
        prayerNewsBtn.backgroundColor = UIColor.clear
        businessBtn.backgroundColor = UIColor.clear
        
        //LatestNews
        self.latest.removeAll()
        
        Alamofire.request("\(baseURL)news.php?category=uttar-pradesh").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let latest = LatestNews(getLatest: obj)
                    self.latest.append(latest)
                }
            }
            self.tableView.reloadData()
        }
        
        //ImageNews
        self.photo.removeAll()
        
        Alamofire.request("\(baseURL)newspics.php?category=uttar-pradesh").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let image = PhotoNews(getPhoto: obj)
                    self.photo.append(image)
                }
            }
            self.tableView.reloadData()
        }
        
        //VideoNews
        self.video.removeAll()
        
        Alamofire.request("\(baseURL)news_videos.php?category=uttar-pradesh").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let video = VideoNews(getVideo: obj)
                    self.video.append(video)
                }
            }
            self.tableView.reloadData()
        }
        
        //ProgramNews
        self.program.removeAll()
        
        Alamofire.request("\(baseURL)news_list.php?id=30").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let program = ProgramNews(getProgram: obj)
                    self.program.append(program)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func specialNewsBtnPressed(_ sender: Any) {
        singleNewsToggle = true
        
        newNewsBtn.backgroundColor = UIColor.clear
        mainNewsBtn.backgroundColor = UIColor.clear
        stateNewsBtn.backgroundColor = UIColor.clear
        worldNewsBtn.backgroundColor = UIColor.clear
        sportsNewsBtn.backgroundColor = UIColor.clear
        entertainmentNewsBtn.backgroundColor = UIColor.clear
        
        homeBtn.backgroundColor = UIColor.clear
        specialNewsBtn.backgroundColor = UIColor.red
        crimeNewsBtn.backgroundColor = UIColor.clear
        healthNewsBtn.backgroundColor = UIColor.clear
        careerNewsBtn.backgroundColor = UIColor.clear
        prayerNewsBtn.backgroundColor = UIColor.clear
        businessBtn.backgroundColor = UIColor.clear
        
        self.latest.removeAll()
        
        Alamofire.request("\(baseURL)news.php?category=khabar-seven").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let latest = LatestNews(getLatest: obj)
                    self.latest.append(latest)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func crimeNewsBtnPressed(_ sender: Any) {
        singleNewsToggle = true
        
        newNewsBtn.backgroundColor = UIColor.clear
        mainNewsBtn.backgroundColor = UIColor.clear
        stateNewsBtn.backgroundColor = UIColor.clear
        worldNewsBtn.backgroundColor = UIColor.clear
        sportsNewsBtn.backgroundColor = UIColor.clear
        entertainmentNewsBtn.backgroundColor = UIColor.clear
        
        homeBtn.backgroundColor = UIColor.clear
        specialNewsBtn.backgroundColor = UIColor.clear
        crimeNewsBtn.backgroundColor = UIColor.red
        healthNewsBtn.backgroundColor = UIColor.clear
        careerNewsBtn.backgroundColor = UIColor.clear
        prayerNewsBtn.backgroundColor = UIColor.clear
        businessBtn.backgroundColor = UIColor.clear
        
        self.latest.removeAll()
        
        Alamofire.request("\(baseURL)news.php?category=crime").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let latest = LatestNews(getLatest: obj)
                    self.latest.append(latest)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func healthNewsBtnPressed(_ sender: Any) {
        singleNewsToggle = true
        
        newNewsBtn.backgroundColor = UIColor.clear
        mainNewsBtn.backgroundColor = UIColor.clear
        stateNewsBtn.backgroundColor = UIColor.clear
        worldNewsBtn.backgroundColor = UIColor.clear
        sportsNewsBtn.backgroundColor = UIColor.clear
        entertainmentNewsBtn.backgroundColor = UIColor.clear
        
        homeBtn.backgroundColor = UIColor.clear
        specialNewsBtn.backgroundColor = UIColor.clear
        crimeNewsBtn.backgroundColor = UIColor.clear
        healthNewsBtn.backgroundColor = UIColor.red
        careerNewsBtn.backgroundColor = UIColor.clear
        prayerNewsBtn.backgroundColor = UIColor.clear
        businessBtn.backgroundColor = UIColor.clear
        
        self.latest.removeAll()
        
        Alamofire.request("\(baseURL)news.php?category=chikitsa").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let latest = LatestNews(getLatest: obj)
                    self.latest.append(latest)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func careerNewsBtnPressed(_ sender: Any) {
        singleNewsToggle = true
        
        newNewsBtn.backgroundColor = UIColor.clear
        mainNewsBtn.backgroundColor = UIColor.clear
        stateNewsBtn.backgroundColor = UIColor.clear
        worldNewsBtn.backgroundColor = UIColor.clear
        sportsNewsBtn.backgroundColor = UIColor.clear
        entertainmentNewsBtn.backgroundColor = UIColor.clear
        
        homeBtn.backgroundColor = UIColor.clear
        specialNewsBtn.backgroundColor = UIColor.clear
        crimeNewsBtn.backgroundColor = UIColor.clear
        healthNewsBtn.backgroundColor = UIColor.clear
        careerNewsBtn.backgroundColor = UIColor.red
        prayerNewsBtn.backgroundColor = UIColor.clear
        businessBtn.backgroundColor = UIColor.clear
        
        self.latest.removeAll()
        
        Alamofire.request("\(baseURL)news.php?category=career").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let latest = LatestNews(getLatest: obj)
                    self.latest.append(latest)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func prayerNewsBtnPressed(_ sender: Any) {
        singleNewsToggle = true
        
        newNewsBtn.backgroundColor = UIColor.clear
        mainNewsBtn.backgroundColor = UIColor.clear
        stateNewsBtn.backgroundColor = UIColor.clear
        worldNewsBtn.backgroundColor = UIColor.clear
        sportsNewsBtn.backgroundColor = UIColor.clear
        entertainmentNewsBtn.backgroundColor = UIColor.clear
        
        homeBtn.backgroundColor = UIColor.clear
        specialNewsBtn.backgroundColor = UIColor.clear
        crimeNewsBtn.backgroundColor = UIColor.clear
        healthNewsBtn.backgroundColor = UIColor.clear
        careerNewsBtn.backgroundColor = UIColor.clear
        prayerNewsBtn.backgroundColor = UIColor.red
        businessBtn.backgroundColor = UIColor.clear
        
        self.latest.removeAll()
        
        Alamofire.request("\(baseURL)news.php?category=shradhha").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let latest = LatestNews(getLatest: obj)
                    self.latest.append(latest)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func businessNewsBtnPressed(_ sender: Any) {
        singleNewsToggle = true
        
        newNewsBtn.backgroundColor = UIColor.clear
        mainNewsBtn.backgroundColor = UIColor.clear
        stateNewsBtn.backgroundColor = UIColor.clear
        worldNewsBtn.backgroundColor = UIColor.clear
        sportsNewsBtn.backgroundColor = UIColor.clear
        entertainmentNewsBtn.backgroundColor = UIColor.clear
        
        homeBtn.backgroundColor = UIColor.clear
        specialNewsBtn.backgroundColor = UIColor.clear
        crimeNewsBtn.backgroundColor = UIColor.clear
        healthNewsBtn.backgroundColor = UIColor.clear
        careerNewsBtn.backgroundColor = UIColor.clear
        prayerNewsBtn.backgroundColor = UIColor.clear
        businessBtn.backgroundColor = UIColor.red
        
        self.latest.removeAll()
        
        Alamofire.request("\(baseURL)news.php?category=business").responseJSON { response in
            if let dict = response.result.value as? [[String: Any]] {
                for obj in dict {
                    let latest = LatestNews(getLatest: obj)
                    self.latest.append(latest)
                }
            }
            self.tableView.reloadData()
        }
    }
    
}

