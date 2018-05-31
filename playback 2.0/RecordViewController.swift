//
//  RecordViewController.swift
//  playback 2.0
//
//  Created by Pradeep Singh on 30/03/2018.
//  Copyright © 2018 Pradeep Singh. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController,AVAudioRecorderDelegate {
    var audioRecorder:AVAudioRecorder!
    @IBOutlet weak var startRecordo: UIButton!
    @IBAction func startRecord(_ sender: Any) {
        RecordingLabel.text="Recording In Progress"
        startRecordo.isEnabled=false
        stopRecordo.isEnabled=true
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate=self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    @IBOutlet weak var RecordingLabel: UILabel!
    @IBOutlet weak var stopRecordo: UIButton!
    
    @IBAction func stopRecord(_ sender: Any) {
        stopRecordo.isEnabled=false
        startRecordo.isEnabled=true
        RecordingLabel.text="Tap To Record"
        audioRecorder.stop()
        let audioSession=AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordo.isEnabled=false
        // Do any additional setup after loading the view, typically from a nib.
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {                //thisfunction programatically change the segue once the file is saved
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else
        {
        print("recording was not successful")
    }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier!=="stopRecording"{
            let playSoudsVC=segue.destination as! PlayViewController
            let recordedAudioURL=sender as! URL
            playSoudsVC.recordedAudioURL = recordedAudioURL
        }
    }


}

