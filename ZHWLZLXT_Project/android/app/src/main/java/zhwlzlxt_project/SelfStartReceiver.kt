package zhwlzlxt_project

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class SelfStartReceiver: BroadcastReceiver() {
    override fun onReceive(p0: Context?, p1: Intent?) {
//        if (Intent.ACTION_BOOT_COMPLETED == p1?.action) {
//            val splashIntent = Intent(p0, MainActivity::class.java)
//            splashIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
//            p0?.startActivity(splashIntent)
//        }
    }
}