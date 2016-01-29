package com.codefolio.util;

//https://github.com/goesang/forweaver
//forweaver의 주요 git 함수를 수정하여 이용


import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.eclipse.jgit.api.ArchiveCommand;
import org.eclipse.jgit.api.Git;
import org.eclipse.jgit.api.errors.GitAPIException;
import org.eclipse.jgit.archive.TarFormat;
import org.eclipse.jgit.archive.ZipFormat;
import org.eclipse.jgit.blame.BlameResult;
import org.eclipse.jgit.diff.DiffFormatter;
import org.eclipse.jgit.dircache.DirCache;
import org.eclipse.jgit.errors.CorruptObjectException;
import org.eclipse.jgit.internal.storage.file.FileRepository;
import org.eclipse.jgit.lib.ObjectId;
import org.eclipse.jgit.lib.ObjectLoader;
import org.eclipse.jgit.lib.PersonIdent;
import org.eclipse.jgit.lib.Ref;
import org.eclipse.jgit.lib.Repository;
import org.eclipse.jgit.lib.RepositoryCache;
import org.eclipse.jgit.lib.StoredConfig;
import org.eclipse.jgit.notes.Note;
import org.eclipse.jgit.revwalk.RevCommit;
import org.eclipse.jgit.revwalk.RevWalk;
import org.eclipse.jgit.storage.file.FileRepositoryBuilder;
import org.eclipse.jgit.transport.PackParser.Source;
import org.eclipse.jgit.treewalk.TreeWalk;
import org.eclipse.jgit.util.FS;
import org.gitective.core.BlobUtils;
import org.gitective.core.CommitUtils;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;


/** git과 관련된 모든 기능 구현.
 *
 */
@Component
public class GitUtils {

	private String gitPath;
	private String path;
	private Repository localRepo;
	private Git git;
	private StoredConfig config;
	private boolean isRepo;
	public Logger log = Logger.getLogger(this.getClass());

	public String getGitPath() {
		return gitPath;
	}

	public void setGitPath(String gitPath) {
		this.gitPath = gitPath;
	}
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Repository getLocalRepo() {
		return localRepo;
	}

	public void setLocalRepo(Repository localRepo) {
		this.localRepo = localRepo;
	}

	public Git getGit() {
		return git;
	}

	public void setGit(Git git) {
		this.git = git;
	}

	public StoredConfig getConfig() {
		return config;
	}

	public void setConfig(StoredConfig config) {
		this.config = config;
	}

	public boolean isRepo() {
		return isRepo;
	}

	public void setRepo(boolean isRepo) {
		this.isRepo = isRepo;
	}

	public GitUtils(){
		this.gitPath = "/home/git/";
	}

	/** 저장소 생성함.
	 * @throws Exception
	 */
	public void createRepository() throws Exception {
		git.init().setBare(true).setDirectory(new File(this.path)).call();
		StoredConfig config = localRepo.getConfig();
		config.setString("http", null, "receivepack", "true");
		config.save();
		if (this.isRepo){
			new File(path + "/refs/tags").setWritable(false, false); // 숙제 및 예제 저장소는 태그 생성 불가
			File hide = new File(path + "/refs/heads/edih"); // 저장소 접근을 막기 위한 디렉토리 추가
			hide.mkdir();
		}
	}



	/** 저장소에서 커밋을 갖고 옴
	 * @param refName
	 * @return
	 */
	public RevCommit getCommit(String refName) {
		return CommitUtils.getCommit(this.localRepo, refName);
	}
	/** 커밋 갯수를 가져옴
	 * @param refName
	 * @return
	 */
	public int getCommitListCount(String refName) {
		try {
			Iterable<RevCommit> gitLogIterable = this.git
					.log()
					.add(
							this.getCommit(refName))
							.call();
			int length = 0;

			for (RevCommit revCommit : gitLogIterable) {
				length++;
			}
			return length;
		} catch (Exception e) {
			return 0;
		}

	}

	/** 프로젝트의 파일 목록을 커밋 아이디를 가지고 가져옴.
	 * @param commitID
	 * @return
	 */
	public List<String> getGitFileList(String commitID) {
		List<String> fileList = new ArrayList<String>();
		try{
			ObjectId revId = this.localRepo.resolve(commitID);
			TreeWalk treeWalk = new TreeWalk(this.localRepo);
			treeWalk.addTree(new RevWalk(this.localRepo).parseTree(revId));
			treeWalk.setRecursive(true);

			while (treeWalk.next()) {
				fileList.add("/"+treeWalk.getPathString());
			}

		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return fileList;
	}




	/** 커밋을 입력받으면 당시 파일들을 압축하여 사용자에게 보내줌.
	 * @param commitName
	 * @param format
	 * @param response
	 */
	public void getProjectZip(String commitName,String format, HttpServletResponse response) {

		try {
			ArchiveCommand.registerFormat("zip", new ZipFormat());
			ArchiveCommand.registerFormat("tar", new TarFormat());
			ObjectId revId = this.localRepo.resolve(commitName);
			git.archive().setOutputStream(response.getOutputStream())
			.setFormat(format)
			.setTree(revId)
			.call();

			ArchiveCommand.unregisterFormat("zip");
			ArchiveCommand.unregisterFormat("tar");
			response.flushBuffer();
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}

	}


	/** GIT이 없이도 프로젝트를 압축하여 업로드하면 자동으로 git에 푸시해주는 기능.
	 * @param name
	 * @param email
	 * @param branchName
	 * @param message
	 * @param zip
	 */
	public void uploadZip(String name,String email,String branchName,String message,MultipartFile zip){
		String directoryPath = "C:/test0101/"+ zip.getOriginalFilename().substring(0, zip.getOriginalFilename().lastIndexOf('.'));

		WebUtil.multipartFileToTempFile(directoryPath+".zip", zip);

		PersonIdent personIdent = new PersonIdent(name, email);
		try {
			// 임시 git 저장소 생성하고 클론.
			File localPath = new File(directoryPath);
			Git.cloneRepository().setURI(this.path).setDirectory(localPath)
			.call();
			// .git을 제외한 파일 모두 삭제.
			Git git = new Git(new FileRepository(new File(localPath.getAbsoluteFile()+ File.separator+".git")));
			this.localRepo = git.getRepository();

			if(!branchName.equals("empty_Branch")) // 브랜치가 존재하지 않는다면 새로 만듬.
				try{
					git.branchCreate().setStartPoint("refs/remotes/origin/"+branchName).setName(branchName).call();
				} 
			catch(Exception e) {}

			if(!branchName.equals("empty_Branch"))
				try{
					git.checkout().setCreateBranch(true).setName(branchName).call();
				} 
			catch(Exception e) 
			{
				git.checkout().setName(branchName).call();
			}

			for(String fileName:getGitFileList(branchName))
				git.rm().addFilepattern(fileName.substring(1)).call();	

			WebUtil.unZip(directoryPath+".zip",  directoryPath,WebUtil.isOneDirectory(directoryPath+".zip"));

			git.add().addFilepattern(".").call();		
			git.commit().setCommitter(personIdent).setAuthor(personIdent).setMessage(message).call();
			git.push().setRemote("origin").call();

			FileUtils.deleteDirectory(new File(this.gitPath));
			new File(directoryPath+".zip").delete();
		} catch (Exception e) {
			System.err.println(e.getMessage());
			try{
				FileUtils.deleteDirectory(new File(directoryPath));
				new File(directoryPath+".zip").delete();
			}catch(Exception ex){}
		}
	}

	
	/** 프로젝트를 포크함.
	 * @param originRepo
	 * @param newRepo
	 */
	public void forkRepository(String originRepo, String newRepo){
		try{
			FileUtils.copyDirectory(new File(gitPath+originRepo+".git"),  new File(gitPath+newRepo+".git"));
		}catch(Exception e){
			System.err.println(e.getMessage());
		}
	}


	/** GIT이 없이도 웹에서 파일을 수정하면 자동으로 git에 푸시해주는 기능.
	 * @param name
	 * @param email
	 * @param branchName
	 * @param message
	 * @param zip
	 */
	//  name email branchname message path code 
	public void updateFile(String name,String email,String branchName,String message,String path,String code){
		String directoryPath = "";

		PersonIdent personIdent = new PersonIdent(name, email);
		try {
			// 임시 git 저장소 생성하고 클론.
			File localPath = new File(directoryPath);
			Git.cloneRepository().setURI(this.path).setDirectory(localPath).call();

			// .git을 제외한 파일 모두 삭제.
			Git git = new Git(new FileRepository(new File(localPath.getAbsoluteFile()+ File.separator+".git")));
			this.localRepo = git.getRepository();

			if(!branchName.equals("empty_Branch")) // 브랜치가 존재하지 않는다면 새로 만듬.
				try{
					git.branchCreate().setStartPoint("refs/remotes/origin/"+branchName).setName(branchName).call();
				} 
			catch(Exception e) {}

			if(!branchName.equals("empty_Branch"))
				try{
					git.checkout().setCreateBranch(true).setName(branchName).call();
				} 
			catch(Exception e) 
			{
				git.checkout().setName(branchName).call();
			}
			
			File file = new File(directoryPath+"/"+path);
			
			if(!file.exists()) // 파일이 존재하지 않는다면.
				throw new Exception();
			
			FileWriter fw= new FileWriter(file); //파일을 수정함.
			fw.write(code);
			fw.close();
			git.add().addFilepattern(".").call();		
			git.commit().setCommitter(personIdent).setAuthor(personIdent).setMessage(message).call();
			git.push().setRemote("origin").call();

			FileUtils.deleteDirectory(new File(directoryPath));
		} catch (Exception e) {
			System.err.println(e.getMessage());
			try{
				FileUtils.deleteDirectory(new File(directoryPath));
			}catch(Exception ex){}
		}
	}


	/** GIT이 없이도 파일을 업로드하면 자동으로 git에 푸시해주는 기능.
	 * @param name
	 * @param email
	 * @param branchName
	 * @param message
	 * @param zip
	 */
	public void uploadFile(String name,String email,String branchName,String message,String path,MultipartFile file){
		String directoryPath = "";

		PersonIdent personIdent = new PersonIdent(name, email);
		try {
			// 임시 git 저장소 생성하고 클론.
			File localPath = new File(directoryPath);
			Git.cloneRepository().setURI(this.path).setDirectory(localPath).call();

			// .git을 제외한 파일 모두 삭제.
			Git git = new Git(new FileRepository(new File(localPath.getAbsoluteFile()+ File.separator+".git")));
			this.localRepo = git.getRepository();

			if(!branchName.equals("empty_Branch")) // 브랜치가 존재하지 않는다면 새로 만듬.
				try{
					git.branchCreate().setStartPoint("refs/remotes/origin/"+branchName).setName(branchName).call();
				} 
			catch(Exception e) {}

			if(!branchName.equals("empty_Branch"))
				try{
					git.checkout().setCreateBranch(true).setName(branchName).call();
				} 
			catch(Exception e) 
			{
				git.checkout().setName(branchName).call();
			}

			boolean existBranch = false; // 브랜치가 존재하는지 여부
			for(String brench:git.getRepository().getAllRefs().keySet())
				if(brench.equals("refs/remotes/origin/"+branchName))
					existBranch = true;

			if(!existBranch) // 새로 브랜치를 만들었다면 다 지움
				for(String fileName:getGitFileList(branchName))
					git.rm().addFilepattern(fileName.substring(1)).call();	

			WebUtil.multipartFileToTempFile(directoryPath+path+"/"+file.getOriginalFilename(), file);
			git.add().addFilepattern(".").call();		
			git.commit().setCommitter(personIdent).setAuthor(personIdent).setMessage(message).call();
			git.push().setRemote("origin").call();

			FileUtils.deleteDirectory(new File(directoryPath));
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}

	
	public List<String> getProjectList(String projectName){
		 FileRepositoryBuilder builder = new FileRepositoryBuilder();
		
		List list= new ArrayList();
        try {
        	log.debug("errororororoor123 "+ "\n");
        	Repository repository = builder
			        .readEnvironment() // scan environment GIT_* variables
			        .setGitDir(new File("C:/test0101/" + projectName +"/.git")) // scan up the file system tree
			        .build();
        	DirCache index = DirCache.read(repository);
        	 ObjectLoader loader = null;
        	log.debug("DirCache has " + index.getEntryCount() + " items");
              for (int i = 0; i < index.getEntryCount(); i++) {
              	log.debug(index.getEntry(i).getPathString()+ "\n");
              	list.add(index.getEntry(i).getPathString());
             
              }
		} catch (IOException e) {
			log.debug("errororororoor "+ "\n");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
        
	}
	
//해당 path의 source를 전달.	
	public String getSource(String projectName, String path) throws UnsupportedEncodingException{
		 FileRepositoryBuilder builder = new FileRepositoryBuilder();
		 ByteArrayOutputStream baos = new ByteArrayOutputStream();
		 
		List list= new ArrayList();
		HashMap<String, ObjectId> map = new HashMap<String, ObjectId>();
		 ObjectLoader loader = null;
       try {
       	Repository repository = builder
			        .readEnvironment() // scan environment GIT_* variables
			        .setGitDir(new File("C:/test0101/" + projectName +"/.git")) // scan up the file system tree
			        .build();
       	DirCache index = DirCache.read(repository);
       	
       	log.debug("DirCache has " + index.getEntryCount() + " items");
             for (int i = 0; i < index.getEntryCount(); i++) {
             	list.add(index.getEntry(i).getPathString());
             	map.put(index.getEntry(i).getPathString(),index.getEntry(i).getObjectId() );
            
             }
             for(int i =0 ; i< list.size(); i++)
             { 
             	if (list.get(i).equals(path))
             	{ 
             		loader = repository.open(map.get(path));
             		loader.copyTo(baos);
             	}
                
             }
             
            
             
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
     
      
		return baos.toString();
       
	}
	
	
	

}
